/**
 * \file    core_protocol.h
 * \brief   XCP protocol glue layer — bridges xcp.c with the TC275 HAL.
 *
 *          Exposes two public functions used by Cpu0_Main.c:
 *            - Core_Protocol_Init() : called once before the backdoor check.
 *            - Core_Protocol_Task() : called repeatedly from the main loop.
 *
 *          Internally, core_protocol.c implements the callbacks required by
 *          xcp.c (ComTransmitPacket, NvmErase, NvmWrite, TimerGet, etc.)
 *          and wires them to HW_CAN, HW_Flash, and HW_System.
 */

#ifndef CORE_OPENBLT_CORE_PROTOCOL_H_
#define CORE_OPENBLT_CORE_PROTOCOL_H_

/*============================================================================
 * Includes
 *===========================================================================*/
#include "Ifx_Types.h"

/*============================================================================
 * Function Prototypes
 *===========================================================================*/

/**
 * \brief   Initialize the XCP state machine.
 *
 *          Resets xcpInfo (connected flag, protection bits, MTA pointer).
 *          Must be called once in core0_main() before Core_Backdoor_Check(),
 *          because the backdoor function calls XcpPacketReceived() on the
 *          very first CONNECT packet — the state machine must be ready.
 */
void Core_Protocol_Init(void);

/**
 * \brief   Non-blocking XCP protocol task.
 *
 *          Polls HW_CAN_Receive() once per call. If a CAN frame is available,
 *          it is forwarded to XcpPacketReceived() for dispatch. If no frame
 *          is available the function returns immediately without blocking.
 *
 *          Must be called continuously from the while(1) loop in core0_main()
 *          to handle XCP commands: PROGRAM_CLEAR, PROGRAM, PROGRAM_RESET, etc.
 */
void Core_Protocol_Task(void);

#endif /* CORE_OPENBLT_CORE_PROTOCOL_H_ */
