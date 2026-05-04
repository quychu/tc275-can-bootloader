/**
 * \file    core_protocol.c
 * \brief   XCP protocol glue layer for the TC275 custom bootloader.
 *
 *          Wires the OpenBLT XCP core (xcp.c) to the TC275 hardware
 *          abstraction layer by implementing the callbacks that xcp.c
 *          expects:
 *
 *          \code
 *          xcp.c  -->  ComTransmitPacket()  -->  HW_CAN_Transmit()
 *          xcp.c  -->  NvmErase()           -->  HW_Flash_Erase()
 *          xcp.c  -->  NvmWrite()           -->  page buffer  -->  HW_Flash_Write()
 *          xcp.c  -->  NvmDone()            -->  flushPageBuffer()
 *          xcp.c  -->  TimerGet()           -->  HW_Timer_GetMs()
 *          xcp.c  -->  CpuStartUserProgram()-->  HW_CPU_JumpToApp()
 *          \endcode
 *
 *          Page buffer rationale:
 *          TC275 PFlash minimal program unit = 32 bytes (one page).
 *          XCP PROGRAM carries at most 6 bytes per CAN frame.
 *          The page buffer accumulates bytes across multiple PROGRAM calls
 *          and writes to Flash only when a complete 32-byte page is ready
 *          or when NvmDone() flushes the final partial page (padded 0xFF).
 */

/*============================================================================
 * Includes
 *===========================================================================*/
#include "xcp_port.h"       /* OpenBLT types + xcp.h forward declarations    */
#include "HW_CAN.h"         /* HW_CAN_Transmit(), HW_CAN_Receive()            */
#include "HW_Flash.h"       /* HW_Flash_Erase(), HW_Flash_Write()             */
#include "HW_System.h"      /* HW_Timer_GetMs()                               */
#include "HW_CPU.h"         /* HW_CPU_JumpToApp()                             */
#include "core_protocol.h"
#include <string.h>         /* memset(), memcpy()                             */

/*============================================================================
 * Private constants
 *===========================================================================*/

/** \brief TC275 PFlash minimal program unit in bytes (one page). */
#define NVM_PAGE_SIZE       (32U)

/** \brief Sentinel value indicating the page buffer holds no valid address. */
#define NVM_ADDR_INVALID    (0xFFFFFFFFUL)

/*============================================================================
 * Private variables
 *===========================================================================*/

/** \brief Page accumulation buffer (located in DSPR / stack frame). */
static uint8  s_pgBuf[NVM_PAGE_SIZE];

/** \brief Page-aligned base address of the data currently in s_pgBuf.
 *         Set to NVM_ADDR_INVALID when the buffer is empty. */
static uint32 s_pgBufAddr  = NVM_ADDR_INVALID;

/** \brief Number of valid bytes populated in s_pgBuf. */
static uint32 s_pgBufBytes = 0U;

/*============================================================================
 * Private function prototypes
 *===========================================================================*/
static blt_bool flushPageBuffer(void);

/*============================================================================
 * Transport layer callbacks  (called by xcp.c)
 *===========================================================================*/

/**
 * \brief   Transmit an XCP response packet over CAN.
 *
 *          Routes the packet to HW_CAN_Transmit() and then calls
 *          XcpPacketTransmitted() to inform the XCP state machine that
 *          the response has left the transmit buffer. Without this ACK,
 *          the state machine would block waiting for confirmation.
 *
 * \param   data  Pointer to the byte array to transmit.
 * \param   len   Number of bytes (max 8 for CAN).
 */
void ComTransmitPacket(blt_int8u *data, blt_int16u len)
{
    HW_CAN_Transmit(data, (uint8)len);
    XcpPacketTransmitted();
}

/**
 * \brief   Return the maximum receive packet size of the active interface.
 * \return  8 — CAN frame data field length.
 */
blt_int16u ComGetActiveInterfaceMaxRxLen(void)
{
    return 8u;
}

/**
 * \brief   Return the maximum transmit packet size of the active interface.
 * \return  8 — CAN frame data field length.
 */
blt_int16u ComGetActiveInterfaceMaxTxLen(void)
{
    return 8u;
}

/*============================================================================
 * NVM layer callbacks  (called by xcp.c)
 *===========================================================================*/

/**
 * \brief   Flush the page buffer to Flash and reset it.
 *
 *          Bytes not yet populated (s_pgBufBytes .. NVM_PAGE_SIZE-1) are
 *          padded with 0xFF, which is the erased state of PFlash and
 *          therefore safe to write without disturbing Flash content.
 *          After the write, the buffer address is invalidated.
 *
 * \return  BLT_TRUE on success or when the buffer was already empty.
 *          BLT_FALSE if HW_Flash_Write() reports an error.
 */
static blt_bool flushPageBuffer(void)
{
    uint32   i;
    blt_bool ok;

    if (s_pgBufBytes == 0U)
    {
        return BLT_TRUE;    /* Nothing to flush. */
    }

    /* Pad the remainder of the page with 0xFF (erased Flash state). */
    for (i = s_pgBufBytes; i < NVM_PAGE_SIZE; i++)
    {
        s_pgBuf[i] = 0xFFU;
    }

    /* Write exactly one aligned 32-byte page. */
    ok = (blt_bool)HW_Flash_Write(s_pgBufAddr, s_pgBuf, NVM_PAGE_SIZE);

    /* Reset the buffer. */
    s_pgBufAddr  = NVM_ADDR_INVALID;
    s_pgBufBytes = 0U;

    return ok;
}

/**
 * \brief   Initialize the NVM page buffer.
 *
 *          Resets the buffer state so that the next NvmWrite() call starts
 *          accumulating into a clean buffer. Called by xcp.c at the beginning
 *          of a programming session (PROGRAM_START).
 *
 * \return  BLT_TRUE always.
 */
blt_bool NvmInit(void)
{
    s_pgBufAddr  = NVM_ADDR_INVALID;
    s_pgBufBytes = 0U;
    return BLT_TRUE;
}

/**
 * \brief   Erase one or more PFlash sectors.
 *
 *          Called by xcp.c on a PROGRAM_CLEAR command. The sector count is
 *          computed from \p len rounded up to the nearest 16 KB sector
 *          boundary (TC275 PFlash smallest sector = 16 KB = 0x4000 bytes).
 *
 * \param   addr  Sector-aligned start address in the non-cached Flash alias
 *                (segment A, e.g. 0xA0008000).
 * \param   len   Number of bytes to erase.
 * \return  BLT_TRUE on success, BLT_FALSE on Flash error.
 */
blt_bool NvmErase(blt_addr addr, blt_int32u len)
{
    /* Round up to the next sector boundary (16 KB = 0x4000 bytes). */
    uint32 numSectors = (len + 0x3FFFU) / 0x4000U;
    return (blt_bool)HW_Flash_Erase((uint32)addr, numSectors);
}

/**
 * \brief   Accumulate firmware bytes into the 32-byte page buffer.
 *
 *          Each call may contribute between 1 and 6 bytes (XCP PROGRAM
 *          over CAN). Bytes are written to Flash only when the page buffer
 *          is full (crossing a 32-byte boundary) — the remainder stays
 *          buffered until the next flush. HW_Flash_Write() is never called
 *          with an unaligned address.
 *
 * \param   addr  Destination Flash address (non-cached segment A).
 * \param   len   Number of bytes provided in this call.
 * \param   data  Pointer to the source data.
 * \return  BLT_TRUE on success, BLT_FALSE if an intermediate Flash write fails.
 */
blt_bool NvmWrite(blt_addr addr, blt_int32u len, blt_int8u *data)
{
    blt_int32u i;
    uint32     pageAddr;
    uint32     pageOff;

    for (i = 0U; i < len; i++)
    {
        /* Page-aligned base address for this byte (floor to multiple of 32). */
        pageAddr = ((uint32)addr + i) & ~(NVM_PAGE_SIZE - 1U);
        /* Byte offset within that page (0 .. 31). */
        pageOff  = ((uint32)addr + i) &  (NVM_PAGE_SIZE - 1U);

        if (pageAddr != s_pgBufAddr)
        {
            /* This byte belongs to a new page — flush the previous one first. */
            if (flushPageBuffer() == BLT_FALSE)
            {
                return BLT_FALSE;
            }

            /* Initialise the new page buffer with 0xFF (safe pad value). */
            s_pgBufAddr  = pageAddr;
            s_pgBufBytes = 0U;
            for (blt_int32u j = 0U; j < NVM_PAGE_SIZE; j++)
            {
                s_pgBuf[j] = 0xFFU;
            }
        }

        /* Place the byte at the correct position within the page. */
        s_pgBuf[pageOff] = data[i];

        /* Track the high-water mark of populated bytes. */
        if ((pageOff + 1U) > s_pgBufBytes)
        {
            s_pgBufBytes = pageOff + 1U;
        }
    }

    return BLT_TRUE;    /* Flash write deferred until page is complete. */
}

/**
 * \brief   Flush the remaining page buffer and end the programming session.
 *
 *          Called by xcp.c when a PROGRAM N=0 packet is received (the
 *          end-of-sequence marker). Writes any partial page still in the
 *          buffer, padded to 32 bytes with 0xFF.
 *
 * \return  BLT_TRUE on success, BLT_FALSE on Flash write error.
 */
blt_bool NvmDone(void)
{
    return flushPageBuffer();
}

/*============================================================================
 * Timer callback  (called by xcp.c)
 *===========================================================================*/

/**
 * \brief   Return the current millisecond timestamp.
 *
 *          Used by xcp.c to detect communication timeouts between XCP
 *          commands.
 *
 * \return  Milliseconds elapsed since bootloader start (wraps at 2^32).
 */
blt_int32u TimerGet(void)
{
    return (blt_int32u)HW_Timer_GetMs();
}

/*============================================================================
 * CPU / Memory callbacks  (called by xcp.c)
 *===========================================================================*/

/**
 * \brief   Start the user application after a successful firmware download.
 *
 *          Called by xcp.c on reception of a PROGRAM_RESET command.
 *          Delegates to HW_CPU_JumpToApp() which:
 *            1. De-initialises MultiCAN+ (prevents ISR vector mismatch).
 *            2. Re-enables the ECC trap (restores default Flash protection).
 *            3. Jumps to APP_FLASH_ENTRY_POINT via an inline assembly JI.
 *
 * \note    This function does not return.
 */
void CpuStartUserProgram(void)
{
    HW_CPU_JumpToApp();
}

/**
 * \brief   Fill a memory block with a constant byte value.
 *
 *          OpenBLT replacement for memset(). Wraps the C library call.
 *
 * \param   dest   Start address of the destination block.
 * \param   value  Byte value to write.
 * \param   len    Number of bytes to fill.
 */
void CpuMemSet(blt_addr dest, blt_int8u value, blt_int16u len)
{
    memset((void *)dest, (int)value, (size_t)len);
}

/**
 * \brief   Copy a block of memory.
 *
 *          OpenBLT replacement for memcpy(). Wraps the C library call.
 *
 * \param   dest  Destination start address.
 * \param   src   Source start address.
 * \param   len   Number of bytes to copy.
 */
void CpuMemCopy(blt_addr dest, blt_addr src, blt_int16u len)
{
    memcpy((void *)dest, (void *)src, (size_t)len);
}

/**
 * \brief   Watchdog service routine (stub).
 *
 *          Called periodically by xcp.c. The TC275 watchdog is disabled at
 *          bootloader startup so this function intentionally does nothing.
 */
void CopService(void)
{
    /* Intentionally empty — watchdog disabled at startup. */
}

/*============================================================================
 * Public API
 *===========================================================================*/

/**
 * \brief   Initialise the XCP state machine.
 *
 *          Calls XcpInit() to reset xcpInfo (connected flag, protection bits,
 *          MTA pointer). Must be called once in core0_main() before
 *          Core_Backdoor_Check() because the backdoor function calls
 *          XcpPacketReceived() on the first CONNECT packet — the state
 *          machine must be initialised before that point.
 */
void Core_Protocol_Init(void)
{
    XcpInit();
}

/**
 * \brief   Non-blocking XCP protocol task.
 *
 *          Polls HW_CAN_Receive() once. If a CAN frame is available it is
 *          forwarded to XcpPacketReceived() for dispatch to the XCP command
 *          handler. If no frame is available the function returns immediately.
 *
 *          Must be called continuously from the while(1) loop in core0_main()
 *          interleaved with the LED toggle so that neither the protocol
 *          response time nor the LED blink rate is compromised.
 */
void Core_Protocol_Task(void)
{
    uint8 rxBuf[8];
    uint8 dlc;

    if (HW_CAN_Receive(rxBuf, &dlc) == TRUE)
    {
        XcpPacketReceived(rxBuf, dlc);
    }
}
