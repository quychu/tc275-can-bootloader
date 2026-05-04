/**
 * \file    HW_System.c
 * \brief   Hardware Abstraction Layer — system timer, watchdog, and LED.
 *
 *          Implements the three system services declared in HW_System.h:
 *            - Watchdog disable (Safety WDT + CPU0 WDT)
 *            - STM0 millisecond timebase calibration and query
 *            - LED heartbeat toggle on P00.5
 *
 *          Architecture:
 *          \code
 *          HW_System (this file) --> iLLD IfxScuWdt / IfxStm / IfxPort --> SCU / STM0 / PORT0
 *          \endcode
 */

#include "HW_System.h"
#include "IfxScuWdt.h"
#include "IfxPort.h"
#include "IfxStm.h"

/** \brief Calibrated STM0 tick count per millisecond (set by HW_Timer_Init()). */
static uint32 stm_ticks_per_ms = 0U;

/**
 * \brief   Initialize system-level hardware.
 *
 *          Step 1 — Watchdog disable:
 *            TC275 has two watchdog timers: a per-CPU watchdog (CPUWDT) and a
 *            safety watchdog (SWDT). Both are enabled by default and expire after
 *            a few milliseconds if not serviced. The bootloader disables both
 *            permanently at startup because it does not service the watchdog.
 *
 *          Step 2 — LED pin configuration:
 *            P00.5 is configured as push-pull general output (LED1 on the TC275
 *            Lite Kit). The LED is active-low: driving the pin HIGH turns it off.
 *            Initial state: HIGH (LED off) to indicate pre-init state clearly.
 */
void HW_System_Init(void)
{
    /* Disable CPU0 watchdog (password must be read before clearing EndInit). */
    IfxScuWdt_disableCpuWatchdog(IfxScuWdt_getCpuWatchdogPassword());

    /* Disable Safety watchdog. */
    IfxScuWdt_disableSafetyWatchdog(IfxScuWdt_getSafetyWatchdogPassword());

    /* Configure P00.5 as push-pull output for LED1. */
    IfxPort_setPinModeOutput(&MODULE_P00, 5,
                             IfxPort_OutputMode_pushPull,
                             IfxPort_OutputIdx_general);

    /* Drive HIGH — LED off (active-low). */
    IfxPort_setPinHigh(&MODULE_P00, 5);
}

/**
 * \brief   Calibrate the STM0 millisecond tick counter.
 *
 *          STM0 runs from the SRI bus clock (fSPB, 100 MHz on this setup) and
 *          starts automatically at power-on. This function reads the running
 *          frequency and computes the ticks-per-millisecond ratio stored in
 *          stm_ticks_per_ms. Subsequent calls to HW_Timer_GetMs() and
 *          HW_Delay_ms() rely on this calibration value.
 */
void HW_Timer_Init(void)
{
    float32 stmFreq    = IfxStm_getFrequency(&MODULE_STM0);
    stm_ticks_per_ms   = (uint32)(stmFreq / 1000.0f);
}

/**
 * \brief   Blocking millisecond delay using STM0.
 *
 *          Captures the current STM0 lower 32-bit counter, then busy-waits
 *          until the elapsed tick count reaches the target. Unsigned 32-bit
 *          subtraction wraps correctly across STM0 counter roll-over, so this
 *          function is safe even if the counter overflows during the wait.
 *
 * \param   ms  Number of milliseconds to delay.
 */
void HW_Delay_ms(uint32 ms)
{
    uint32 total_ticks = ms * stm_ticks_per_ms;
    uint32 start_tick  = IfxStm_getLower(&MODULE_STM0);

    while ((IfxStm_getLower(&MODULE_STM0) - start_tick) < total_ticks)
    {
        /* Busy wait — intentionally empty. */
    }
}

/**
 * \brief   Return milliseconds elapsed since bootloader start.
 *
 *          Reads the lower 32-bit STM0 counter and divides by the calibrated
 *          ticks-per-millisecond ratio. The result wraps at 2^32 ticks
 *          (~23 days at 100 MHz fSTM), which is not a concern for bootloader
 *          operation.
 *
 * \return  Milliseconds since HW_Timer_Init() was called.
 */
uint32 HW_Timer_GetMs(void)
{
    return IfxStm_getLower(&MODULE_STM0) / stm_ticks_per_ms;
}

/**
 * \brief   Toggle the bootloader heartbeat LED on P00.5.
 *
 *          Inverts the output state of P00.5 via IfxPort_togglePin().
 *          Called from core0_main() every 100 ms using a non-blocking
 *          timer delta to avoid stalling the XCP protocol loop.
 */
void HW_LED_Toggle(void)
{
    IfxPort_togglePin(&MODULE_P00, 5);
}
