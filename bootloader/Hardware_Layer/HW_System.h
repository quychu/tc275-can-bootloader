/**
 * \file    HW_System.h
 * \brief   Hardware Abstraction Layer for system-level peripherals.
 *
 *          Manages three system resources used by the bootloader:
 *            - CPU and Safety Watchdog timers (disabled at startup)
 *            - System Timer STM0 (millisecond timebase for backdoor and LED)
 *            - LED indicator on P00.5 (bootloader heartbeat)
 *
 *          Architecture:
 *          \code
 *          HW_System (this file) --> iLLD IfxScuWdt / IfxStm / IfxPort --> SCU / STM0 / PORT HW
 *          \endcode
 */

#ifndef HARDWARE_LAYER_HW_SYSTEM_H_
#define HARDWARE_LAYER_HW_SYSTEM_H_

#ifndef HW_SYSTEM_H
#define HW_SYSTEM_H

#include "Ifx_Types.h"

/**
 * \brief   Initialize system-level hardware.
 *
 *          Performs the following steps:
 *            1. Disable CPU0 watchdog (default timeout ~3 ms — must be disabled
 *               before any significant initialization time elapses).
 *            2. Disable Safety watchdog.
 *            3. Configure P00.5 as push-pull output (LED1 on TC275 Lite Kit,
 *               active-low: LOW = LED on, HIGH = LED off).
 *            4. Drive P00.5 HIGH to ensure LED is off at startup.
 */
void HW_System_Init(void);

/**
 * \brief   Calibrate the STM0 millisecond tick counter.
 *
 *          STM0 starts automatically at power-on. This function reads
 *          the STM frequency via IfxStm_getFrequency() and stores the
 *          ticks-per-millisecond ratio used by HW_Timer_GetMs() and
 *          HW_Delay_ms(). Must be called before any timer-dependent function.
 */
void HW_Timer_Init(void);

/**
 * \brief   Blocking millisecond delay.
 *
 *          Busy-waits by polling STM0 until \p ms milliseconds have elapsed.
 *          Unsigned subtraction is safe across STM0 32-bit counter wrap-around.
 *
 * \param   ms  Number of milliseconds to wait.
 *
 * \note    Do NOT call this inside the main protocol loop — it blocks
 *          XCP packet processing. Use the non-blocking timer delta pattern
 *          (HW_Timer_GetMs() - lastMs >= interval) instead.
 */
void HW_Delay_ms(uint32 ms);

/**
 * \brief   Return the number of milliseconds elapsed since bootloader start.
 *
 *          Reads the lower 32-bit counter of STM0 and divides by the
 *          calibrated ticks-per-millisecond ratio. Wraps around at 2^32 ticks
 *          (~49 days at 200 MHz fSTM), which is irrelevant for bootloader use.
 *
 * \return  Milliseconds elapsed since HW_Timer_Init() was called.
 */
uint32 HW_Timer_GetMs(void);

/**
 * \brief   Toggle the bootloader heartbeat LED on P00.5.
 *
 *          Called from the main loop every 100 ms (non-blocking timer delta)
 *          to indicate that the bootloader is running and waiting for a host.
 *          Uses IfxPort_togglePin() for a single-instruction atomic toggle.
 */
void HW_LED_Toggle(void);

#endif /* HW_SYSTEM_H */
#endif /* HARDWARE_LAYER_HW_SYSTEM_H_ */
