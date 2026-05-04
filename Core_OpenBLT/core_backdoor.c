/**
 * \file    core_backdoor.c
 * \brief   Backdoor timer window implementation.
 *
 *          Polls the CAN bus for XCP_CMD_CONNECT (0xFF) during a fixed time
 *          window (BACKDOOR_TIMEOUT_MS). On a match, the XCP state machine
 *          is notified immediately via XcpPacketReceived() so that subsequent
 *          protocol commands (PROGRAM_CLEAR, PROGRAM, etc.) are accepted
 *          without an additional handshake.
 */

#include "Ifx_Types.h"
#include "HW_CAN.h"
#include "HW_System.h"      /* HW_Timer_GetMs()           */
#include "app_config.h"     /* BACKDOOR_TIMEOUT_MS = 3000 */
#include "core_backdoor.h"

/* XcpPacketReceived() is defined in xcp.c (OpenBLT core). */
extern void XcpPacketReceived(uint8 *data, uint8 len);

/*============================================================================
 * Function Implementations
 *===========================================================================*/

/**
 * \brief   Poll the CAN bus for an XCP CONNECT command.
 *
 *          Runs a busy-poll loop for at most BACKDOOR_TIMEOUT_MS milliseconds.
 *          Non-CONNECT CAN frames that arrive during the window are silently
 *          discarded so that bus noise cannot trigger a false positive.
 *
 *          When CONNECT is detected, XcpPacketReceived() is invoked before
 *          returning so the XCP state machine has already processed the
 *          CONNECT and sent its positive response by the time the caller
 *          enters the main protocol loop.
 *
 * \return  BACKDOOR_ACTIVE  — XCP session established.
 *          BACKDOOR_TIMEOUT — Timeout expired with no valid CONNECT received.
 */
BackdoorResult_t Core_Backdoor_Check(void)
{
    uint8  rxBuf[8];
    uint8  dlc;
    uint32 startTick;
    uint32 elapsed;

    startTick = HW_Timer_GetMs();

    for (;;)
    {
        /* Unsigned subtraction is safe on STM counter wrap-around. */
        elapsed = HW_Timer_GetMs() - startTick;

        if (elapsed >= BACKDOOR_TIMEOUT_MS)
        {
            return BACKDOOR_TIMEOUT;
        }

        if (HW_CAN_Receive(rxBuf, &dlc) == TRUE)
        {
            if (rxBuf[0] == XCP_CMD_CONNECT)
            {
                /*
                 * Forward the CONNECT packet to the XCP state machine now.
                 * Mandatory: xcp.c must process CONNECT (set connected flag,
                 * send positive response) before this function returns.
                 * Deferring the call would cause every subsequent XCP command
                 * to be rejected with ERR_SEQUENCE.
                 */
                XcpPacketReceived(rxBuf, dlc);
                return BACKDOOR_ACTIVE;
            }
            /* Non-CONNECT frame — discard and continue polling. */
        }
    }
}
