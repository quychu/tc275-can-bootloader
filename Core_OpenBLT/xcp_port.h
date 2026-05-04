/**
 * \file    xcp_port.h
 * \brief   Minimal OpenBLT porting header for the TC275 custom bootloader.
 *
 *          Replaces boot.h from the OpenBLT reference port (TRICORE_TC2).
 *          Provides:
 *            1. OpenBLT type aliases  (blt_bool, blt_addr, blt_int8u, ...)
 *            2. Boot configuration macros  (CAN only, security disabled)
 *            3. Forward declarations for glue callbacks implemented in
 *               core_protocol.c  (ComTransmitPacket, NvmErase, NvmWrite, ...)
 *            4. Inclusion of xcp.h so that every file that includes this
 *               header gets the full XCP API.
 *
 * \note    xcp.c includes this file instead of the original boot.h, allowing
 *          the OpenBLT XCP core to be used unmodified.
 */

#ifndef CORE_OPENBLT_XCP_PORT_H_
#define CORE_OPENBLT_XCP_PORT_H_

/*============================================================================
 * 1. OpenBLT type definitions  (mirrors TRICORE_TC2/types.h)
 *===========================================================================*/

/** \brief Boolean true value used throughout OpenBLT. */
#define BLT_TRUE        (1)
/** \brief Boolean false value used throughout OpenBLT. */
#define BLT_FALSE       (0)
/** \brief Null pointer used throughout OpenBLT. */
#define BLT_NULL        ((void *)0)

typedef unsigned char   blt_bool;   /**< Boolean type (BLT_TRUE / BLT_FALSE). */
typedef char            blt_char;   /**< Character type.                        */
typedef unsigned long   blt_addr;   /**< Memory address type (32-bit).          */
typedef unsigned char   blt_int8u;  /**< Unsigned  8-bit integer.               */
typedef signed   char   blt_int8s;  /**< Signed    8-bit integer.               */
typedef unsigned short  blt_int16u; /**< Unsigned 16-bit integer.               */
typedef signed   short  blt_int16s; /**< Signed   16-bit integer.               */
typedef unsigned int    blt_int32u; /**< Unsigned 32-bit integer.               */
typedef signed   int    blt_int32s; /**< Signed   32-bit integer.               */

/*============================================================================
 * 2. Boot configuration  (CAN transport only)
 *===========================================================================*/

/** \brief Enable the communication interface (CAN). */
#define BOOT_COM_ENABLE                 (1)
/** \brief TC275 TriCore is Intel little-endian; Motorola byte order disabled. */
#define BOOT_CPU_BYTE_ORDER_MOTOROLA    (0)

/* XCP optional features — all disabled to keep the implementation minimal. */
#define BOOT_XCP_SEED_KEY_ENABLE        (0) /**< Seed/key security disabled.       */
#define BOOT_XCP_UPLOAD_ENABLE          (0) /**< Memory read-back disabled.        */
#define BOOT_XCP_PACKET_RECEIVED_HOOK   (0) /**< Packet hook disabled.             */
#define BOOT_XCP_SEED_MAX_LEN           (0) /**< Seed length (unused).             */
#define BOOT_XCP_KEY_MAX_LEN            (0) /**< Key length (unused).              */
#define BOOT_EVENTS_ENABLE              (0) /**< Event channel disabled.           */

/** \brief Maximum RX packet size in bytes (CAN frame data field). */
#define BOOT_COM_RX_MAX_DATA            (8u)
/** \brief Maximum TX packet size in bytes (CAN frame data field). */
#define BOOT_COM_TX_MAX_DATA            (8u)

/*============================================================================
 * 3. Glue callback declarations  (implemented in core_protocol.c)
 *===========================================================================*/

/**
 * \brief   Transmit an XCP response packet over CAN.
 *
 *          Called by xcp.c whenever a response must be sent to the host.
 *          Routes the packet through HW_CAN_Transmit() and acknowledges
 *          transmission via XcpPacketTransmitted().
 *
 * \param   data  Pointer to the response byte array.
 * \param   len   Number of bytes to transmit (max BOOT_COM_TX_MAX_DATA).
 */
void        ComTransmitPacket(blt_int8u *data, blt_int16u len);

/**
 * \brief   Return the maximum RX packet size of the active interface.
 * \return  8 (CAN frame data field size).
 */
blt_int16u  ComGetActiveInterfaceMaxRxLen(void);

/**
 * \brief   Return the maximum TX packet size of the active interface.
 * \return  8 (CAN frame data field size).
 */
blt_int16u  ComGetActiveInterfaceMaxTxLen(void);

/**
 * \brief   Initialize the NVM page buffer.
 *
 *          Resets the internal page accumulation buffer so that the next
 *          NvmWrite() call starts fresh.
 *
 * \return  BLT_TRUE always.
 */
blt_bool    NvmInit(void);

/**
 * \brief   Erase one or more PFlash sectors.
 *
 *          Called by xcp.c on a PROGRAM_CLEAR command.
 *          The address must use the non-cached alias (segment A, 0xAxxxxxxx)
 *          as required by the TC275 Flash Command Sequence.
 *
 * \param   addr  Start address of the region to erase (sector-aligned).
 * \param   len   Number of bytes to erase (rounded up to sector boundaries).
 * \return  BLT_TRUE on success, BLT_FALSE on Flash error.
 */
blt_bool    NvmErase(blt_addr addr, blt_int32u len);

/**
 * \brief   Accumulate firmware bytes into the internal 32-byte page buffer.
 *
 *          Called by xcp.c on each PROGRAM command (up to 6 bytes per call).
 *          Data is not written to Flash immediately; it is held in the page
 *          buffer until a full 32-byte page is complete or NvmDone() is
 *          called to flush the last partial page.
 *
 * \param   addr  Destination Flash address (non-cached segment A).
 * \param   len   Number of bytes in this call.
 * \param   data  Pointer to the source data buffer.
 * \return  BLT_TRUE on success, BLT_FALSE on Flash write error.
 */
blt_bool    NvmWrite(blt_addr addr, blt_int32u len, blt_int8u *data);

/**
 * \brief   Flush the page buffer and finalize the programming session.
 *
 *          Called by xcp.c when a PROGRAM N=0 packet is received.
 *          Writes any remaining bytes in the page buffer (padded with 0xFF)
 *          to Flash, then resets the buffer.
 *
 * \return  BLT_TRUE on success, BLT_FALSE on Flash write error.
 */
blt_bool    NvmDone(void);

/**
 * \brief   Return a millisecond timestamp.
 *
 *          Used by xcp.c to detect communication timeouts.
 *
 * \return  Elapsed milliseconds since bootloader start (wraps at 2^32 ms).
 */
blt_int32u  TimerGet(void);

/**
 * \brief   Set a block of memory to a given byte value.
 *
 *          OpenBLT replacement for the standard memset(). Implemented via
 *          the C library memset() in core_protocol.c.
 *
 * \param   dest   Destination address.
 * \param   value  Byte value to write.
 * \param   len    Number of bytes to set.
 */
void        CpuMemSet(blt_addr dest, blt_int8u value, blt_int16u len);

/**
 * \brief   Copy a block of memory.
 *
 *          OpenBLT replacement for the standard memcpy(). Implemented via
 *          the C library memcpy() in core_protocol.c.
 *
 * \param   dest  Destination address.
 * \param   src   Source address.
 * \param   len   Number of bytes to copy.
 */
void        CpuMemCopy(blt_addr dest, blt_addr src, blt_int16u len);

/**
 * \brief   Watchdog service routine (stub).
 *
 *          Called periodically by xcp.c. The TC275 watchdog is disabled at
 *          bootloader startup, so this function intentionally does nothing.
 */
void        CopService(void);

/**
 * \brief   Start the user application.
 *
 *          Called by xcp.c when a PROGRAM_RESET command is received
 *          (firmware download complete). Delegates to HW_CPU_JumpToApp()
 *          which de-initializes peripherals and jumps to APP_FLASH_ENTRY_POINT.
 *          This function does not return.
 */
void        CpuStartUserProgram(void);

/*============================================================================
 * 4. XCP core header
 *===========================================================================*/

/** \brief Include the OpenBLT XCP core — must come after all type/macro defs. */
#include "xcp.h"

#endif /* CORE_OPENBLT_XCP_PORT_H_ */
