/**
 * \file    HW_CAN.c
 * \brief   Hardware Abstraction Layer — TC275 MultiCAN+ driver (polling mode).
 *
 *          Configures one CAN node (Node 0) and two message objects:
 *            - TX MsgObj 0 : ID 0x7E1 (bootloader response to host)
 *            - RX MsgObj 1 : ID 0x667, exact-match mask 0x7FF (host commands)
 *
 *          Architecture:
 *          \code
 *          HW_CAN (this file) --> iLLD IfxMultican_Can --> MultiCAN+ HW (0xF001_8000)
 *          \endcode
 *
 *          Design decisions:
 *            - Polling only (no interrupts): simpler, deterministic latency.
 *            - Static handles (g_canModule, g_canNode0, g_canMsgObj*): iLLD
 *              tracks hardware state through these structs; they must remain
 *              valid for the entire bootloader lifetime.
 *            - CAN transceiver TLE6251 (P20.6 STBY): must be driven LOW before
 *              any message can appear on the physical bus.
 */

#include "HW_CAN.h"
#include "IfxMultican_PinMap.h"
#include "IfxMultican_Can.h"
#include "IfxPort.h"

/*============================================================================
 * Private variables — iLLD state handles (file-scope only)
 *===========================================================================*/

/** \brief Handle for the entire MultiCAN+ module. */
static IfxMultican_Can        g_canModule;

/** \brief Handle for CAN Node 0 (physical bus, 500 kbps). */
static IfxMultican_Can_Node   g_canNode0;

/** \brief Handle for TX Message Object 0 (ID 0x7E1). */
static IfxMultican_Can_MsgObj g_canMsgObjTx;

/** \brief Handle for RX Message Object 1 (ID 0x667). */
static IfxMultican_Can_MsgObj g_canMsgObjRx;

/*============================================================================
 * Function Implementations
 *===========================================================================*/

/**
 * \brief   Initialize the CAN hardware subsystem.
 *
 *          Initialization order is mandatory — each layer depends on the one above:
 *            1. Transceiver (P20.6 LOW) — physical bus enable.
 *            2. MultiCAN+ module — enables the peripheral clock (CAN_CLC).
 *            3. CAN Node 0 — configures the bit timing register (NBTR) for 500 kbps.
 *            4. TX MsgObj 0 — host receives XCP responses on 0x7E1.
 *            5. RX MsgObj 1 — accepts only frames with ID 0x667 (exact match).
 */
void HW_CAN_Init(void)
{
    /* 1. Enable CAN transceiver TLE6251 on TC275 Lite Kit.
     *    P20.6 (STBY): LOW = Normal mode, HIGH = Standby (bus disabled).
     *    Without this step the physical TX/RX lines carry no signal. */
    IfxPort_setPinMode(&MODULE_P20, 6, IfxPort_Mode_outputPushPullGeneral);
    IfxPort_setPinLow(&MODULE_P20, 6);

    /* 2. Initialize MultiCAN+ module.
     *    initModuleConfig() fills canConfig with iLLD defaults.
     *    initModule() writes CAN_CLC to enable the peripheral clock. */
    IfxMultican_Can_Config canConfig;
    IfxMultican_Can_initModuleConfig(&canConfig, &MODULE_CAN);
    IfxMultican_Can_initModule(&g_canModule, &canConfig);

    /* 3. Initialize CAN Node 0.
     *    iLLD calculates NBTR (bit timing register) from baudrate and
     *    fCAN (= fSPB = fSYS/2 = 100 MHz on this board).
     *    rxPinMode = pullUp keeps the RX line HIGH (recessive) when idle. */
    IfxMultican_Can_NodeConfig canNodeConfig;
    IfxMultican_Can_Node_initConfig(&canNodeConfig, &g_canModule);
    canNodeConfig.baudrate   = BOOT_COM_CAN_BAUDRATE;         /* 500 kbps */
    canNodeConfig.nodeId     = IfxMultican_NodeId_0;
    canNodeConfig.rxPin      = &IfxMultican_RXD0B_P20_7_IN;
    canNodeConfig.rxPinMode  = IfxPort_InputMode_pullUp;
    canNodeConfig.txPin      = &IfxMultican_TXD0_P20_8_OUT;
    canNodeConfig.txPinMode  = IfxPort_OutputMode_pushPull;
    IfxMultican_Can_Node_init(&g_canNode0, &canNodeConfig);

    /* 4. Initialize TX Message Object 0 (transmit frame, ID 0x7E1).
     *    When the CPU writes data and sets TXRQ, the hardware arbitrates
     *    and transmits the frame onto the bus automatically. */
    IfxMultican_Can_MsgObjConfig canMsgObjConfigTx;
    IfxMultican_Can_MsgObj_initConfig(&canMsgObjConfigTx, &g_canNode0);
    canMsgObjConfigTx.msgObjId   = 0;
    canMsgObjConfigTx.messageId  = BOOT_COM_CAN_TX_MSG_ID;   /* 0x7E1 */
    canMsgObjConfigTx.frame      = IfxMultican_Frame_transmit;
    IfxMultican_Can_MsgObj_init(&g_canMsgObjTx, &canMsgObjConfigTx);

    /* 5. Initialize RX Message Object 1 (receive frame, ID 0x667).
     *    acceptanceMask = 0x7FF: all 11 ID bits must match exactly.
     *    Filter logic: accept when (receivedID XOR messageID) AND mask == 0.
     *    Polling (no interrupt) is used for simplicity and deterministic timing. */
    IfxMultican_Can_MsgObjConfig canMsgObjConfigRx;
    IfxMultican_Can_MsgObj_initConfig(&canMsgObjConfigRx, &g_canNode0);
    canMsgObjConfigRx.msgObjId        = 1;
    canMsgObjConfigRx.messageId       = BOOT_COM_CAN_RX_MSG_ID; /* 0x667 */
    canMsgObjConfigRx.acceptanceMask  = 0x7FFU;
    canMsgObjConfigRx.frame           = IfxMultican_Frame_receive;
    IfxMultican_Can_MsgObj_init(&g_canMsgObjRx, &canMsgObjConfigRx);
}

/**
 * \brief   Poll the RX Message Object for a new CAN frame.
 *
 *          iLLD stores the 8-byte CAN payload in two uint32 words (data[0],
 *          data[1]). This function unpacks them byte-by-byte using TriCore
 *          little-endian byte ordering (byte 0 at bits [7:0] of data[0]).
 *
 *          readMessage() reads MODATA and clears the NEWDAT hardware flag
 *          atomically, so a subsequent call returns FALSE until a new frame
 *          arrives.
 *
 * \param   data  Output buffer (8 bytes).
 * \param   dlc   Output — number of valid bytes in \p data (0–8).
 * \return  TRUE if a new frame was available; FALSE otherwise.
 */
boolean HW_CAN_Receive(uint8 *data, uint8 *dlc)
{
    IfxMultican_Message rxMsg;

    IfxMultican_Status status = IfxMultican_Can_MsgObj_readMessage(&g_canMsgObjRx, &rxMsg);

    if (status == IfxMultican_Status_newData)
    {
        *dlc = (uint8)rxMsg.lengthCode;

        for (uint8 i = 0U; i < *dlc; i++)
        {
            if (i < 4U)
            {
                /* Bytes 0–3 are in data[0] (low word). */
                data[i] = (uint8)(rxMsg.data[0] >> (i * 8U));
            }
            else
            {
                /* Bytes 4–7 are in data[1] (high word).
                 * Subtract 4 to bring the byte index back to bit [7:0]. */
                data[i] = (uint8)(rxMsg.data[1] >> ((i - 4U) * 8U));
            }
        }
        return TRUE;
    }
    return FALSE;
}

/**
 * \brief   Pack a byte buffer into iLLD uint32 words and transmit via TX MsgObj 0.
 *
 *          Packing is the reverse of the unpack in HW_CAN_Receive():
 *            dataLow  |= (uint32)data[i] << (i * 8)        — bytes 0–3
 *            dataHigh |= (uint32)data[i] << ((i-4) * 8)    — bytes 4–7
 *
 * \param   data  Payload to transmit.
 * \param   dlc   Number of bytes (1–8).
 * \return  TRUE if the iLLD transmit call accepted the frame; FALSE on error.
 */
boolean HW_CAN_Transmit(const uint8 *data, uint8 dlc)
{
    IfxMultican_Message txMsg;
    uint32 dataLow  = 0U;
    uint32 dataHigh = 0U;

    for (uint8 i = 0U; i < dlc; i++)
    {
        if (i < 4U)
        {
            dataLow  |= ((uint32)data[i] << (i * 8U));
        }
        else
        {
            dataHigh |= ((uint32)data[i] << ((i - 4U) * 8U));
        }
    }

    IfxMultican_Message_init(&txMsg, BOOT_COM_CAN_TX_MSG_ID,
                             dataLow, dataHigh,
                             (IfxMultican_DataLengthCode)dlc);

    IfxMultican_Status status = IfxMultican_Can_MsgObj_sendMessage(&g_canMsgObjTx, &txMsg);

    return (status == IfxMultican_Status_ok) ? TRUE : FALSE;
}

/**
 * \brief   Disable the MultiCAN+ module.
 *
 *          Writes CAN_CLC.B.DISR = 1 (clock gate off) via IfxMultican_disableModule().
 *          After this call, no CAN interrupt can fire and the TX/RX mailboxes
 *          are inactive.
 *
 * \note    Must be called before HW_CPU_JumpToApp(). The bootloader and the
 *          application have different interrupt vector tables (BIV). If a CAN
 *          frame arrives after the application starts but before the application
 *          has configured its own BIV, the ISR would jump into the bootloader's
 *          handler — causing undefined behavior or a CPU trap.
 */
void HW_CAN_DeInit(void)
{
    IfxMultican_disableModule(&MODULE_CAN);
}
