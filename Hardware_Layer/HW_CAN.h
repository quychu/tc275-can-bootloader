/**
 * \file    HW_CAN.h
 * \brief   Hardware Abstraction Layer for the TC275 MultiCAN+ peripheral.
 *
 *          Wraps the iLLD IfxMultican_Can API to provide a simple polling-based
 *          CAN interface used exclusively by the bootloader:
 *            - One CAN Node (Node 0, 500 kbps, TLE6251 transceiver)
 *            - One TX Message Object (ID 0x7E1 — MicroBoot convention)
 *            - One RX Message Object (ID 0x667, exact-match acceptance mask 0x7FF)
 *
 *          Architecture:
 *          \code
 *          HW_CAN (this file) --> iLLD IfxMultican_Can --> MultiCAN+ HW (0xF001_8000)
 *          \endcode
 */

#ifndef HARDWARE_LAYER_HW_CAN_H_
#define HARDWARE_LAYER_HW_CAN_H_

#include "Ifx_Types.h"
#include "app_config.h"

/** \brief Maximum number of data bytes in a standard CAN 2.0A/B frame. */
#define HW_CAN_DLC_MAX          (8U)

/**
 * \brief   Initialize the CAN hardware subsystem.
 *
 *          Performs the following initialization sequence (order is mandatory):
 *            1. Enable CAN transceiver (TLE6251, P20.6 STBY = LOW)
 *            2. Initialize MultiCAN+ module (enable clock via CAN_CLC)
 *            3. Initialize CAN Node 0 at BOOT_COM_CAN_BAUDRATE (500 kbps)
 *            4. Configure TX Message Object 0 (ID 0x7E1, transmit frame)
 *            5. Configure RX Message Object 1 (ID 0x667, exact-match mask 0x7FF)
 */
void HW_CAN_Init(void);

/**
 * \brief   Poll the RX Message Object for a new CAN frame (non-blocking).
 *
 *          Reads MODATA from Message Object 1 and clears the NEWDAT flag.
 *          Returns immediately if no frame is available.
 *
 * \param   data  Pointer to an 8-byte buffer that receives the frame payload.
 * \param   dlc   Pointer to a variable that receives the actual byte count (0–8).
 * \return  TRUE  if a new frame was available and copied into \p data.
 *          FALSE if the RX mailbox was empty.
 */
boolean HW_CAN_Receive(uint8 *data, uint8 *dlc);

/**
 * \brief   Transmit one CAN frame via TX Message Object 0.
 *
 *          Packs the byte buffer into the two uint32 data words expected by
 *          iLLD (little-endian byte order: byte 0 at bits [7:0] of word 0),
 *          then submits the frame to the hardware transmit request.
 *
 * \param   data  Pointer to the payload buffer to transmit.
 * \param   dlc   Number of bytes to send (1–8).
 * \return  TRUE  if the frame was accepted by the TX mailbox.
 *          FALSE if the iLLD transmit call reported an error.
 */
boolean HW_CAN_Transmit(const uint8 *data, uint8 dlc);

/**
 * \brief   Disable the MultiCAN+ module before jumping to the application.
 *
 *          Writes CAN_CLC.B.DISR = 1 (clock gate off) via IfxMultican_disableModule().
 *          This must be called before HW_CPU_JumpToApp() to prevent stale CAN
 *          interrupts from firing into the bootloader's ISR vector table while
 *          the application is initializing its own BIV.
 */
void HW_CAN_DeInit(void);

#endif /* HARDWARE_LAYER_HW_CAN_H_ */
