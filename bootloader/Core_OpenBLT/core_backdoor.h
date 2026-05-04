/**
 * \file    core_backdoor.h
 * \brief   Backdoor timer window for XCP bootloader entry.
 *
 *          Polls the CAN bus for a configurable timeout window
 *          (BACKDOOR_TIMEOUT_MS). If an XCP CONNECT command is received
 *          within the window, the bootloader stays active for firmware
 *          download. Otherwise, execution is handed off to the application.
 */

#ifndef CORE_OPENBLT_CORE_BACKDOOR_H_
#define CORE_OPENBLT_CORE_BACKDOOR_H_

#include "Ifx_Types.h"

/*============================================================================
 * Macros
 *===========================================================================*/

/** \brief First byte value of an XCP CONNECT packet. */
#define XCP_CMD_CONNECT     (0xFFu)

/*============================================================================
 * Data Structures
 *===========================================================================*/

/**
 * \brief Return status of Core_Backdoor_Check().
 */
typedef enum
{
    BACKDOOR_TIMEOUT = 0,   /**< Timeout elapsed — no host connected.          */
    BACKDOOR_ACTIVE  = 1    /**< XCP CONNECT received — bootloader is active.  */
} BackdoorResult_t;

/*============================================================================
 * Function Prototypes
 *===========================================================================*/

/**
 * \brief   Poll the CAN bus for an XCP CONNECT command within the backdoor
 *          time window.
 *
 *          The function blocks (busy-polls HW_CAN_Receive) for up to
 *          BACKDOOR_TIMEOUT_MS milliseconds. On receiving a valid CONNECT
 *          packet, it calls XcpPacketReceived() immediately so that the XCP
 *          state machine transitions to CONNECTED before this function
 *          returns BACKDOOR_ACTIVE.
 *
 * \return  BACKDOOR_ACTIVE  — XCP session established; caller should enter
 *                             the main protocol loop.
 *          BACKDOOR_TIMEOUT — No host connected; caller should verify the
 *                             application checksum and jump to the app.
 */
BackdoorResult_t Core_Backdoor_Check(void);

#endif /* CORE_OPENBLT_CORE_BACKDOOR_H_ */
