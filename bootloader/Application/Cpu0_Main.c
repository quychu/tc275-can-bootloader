/**
 * \file    Cpu0_Main.c
 * \brief   CPU0 entry point for the TC275 custom bootloader (OpenBLT-based).
 *
 *          This file contains \c core0_main(), which is the first user-space
 *          function executed after the BootROM verifies the BMHD and jumps to
 *          the bootloader reset vector (0x80000020).
 *
 *          Execution flow after reset:
 *          \code
 *          BootROM (0x8FFF8000)            -- Infineon ROM; verifies BMHD/BMI
 *               |
 *          core0_main (0x80000020)         -- Bootloader entry
 *               |
 *          HW_CPU_Disable_ECC_Trap()       -- Suppress ECC trap for blank Flash reads
 *          HW_System_Init()                -- Disable WDT; configure LED pin
 *          HW_Timer_Init()                 -- Calibrate STM0 millisecond counter
 *          HW_CAN_Init()                   -- MultiCAN+ Node 0, 500 kbps
 *          Core_Protocol_Init()            -- Reset XCP state machine
 *               |
 *          Core_Backdoor_Check() ---- 3 s window ------+
 *               |                                      |
 *               | BACKDOOR_ACTIVE                BACKDOOR_TIMEOUT
 *               | (host connected)                     |
 *               |                         HW_CPU_Verify_App_Checksum()
 *               |                              VALID |      | INVALID
 *               |                         JumpToApp()|      | (stay in BL)
 *               |
 *          while(1)
 *            Core_Protocol_Task()          -- Non-blocking XCP packet dispatch
 *            LED toggle every 100 ms       -- Non-blocking heartbeat indicator
 *          \endcode
 *
 * \note    CPU1 and CPU2 are not used by the bootloader. They remain in their
 *          respective idle loops (core1_main / core2_main) with watchdogs
 *          disabled until the application releases them.
 */

#include "Ifx_Types.h"
#include "IfxCpu.h"
#include "IfxScuWdt.h"
#include "Cpu/CStart/IfxCpu_CStart.h"

#include "HW_System.h"      /* HW_System_Init(), HW_Timer_Init(), HW_LED_Toggle()          */
#include "HW_CAN.h"         /* HW_CAN_Init()                                               */
#include "HW_CPU.h"         /* HW_CPU_Disable_ECC_Trap(), HW_CPU_Verify_App_Checksum(),
                               HW_CPU_JumpToApp()                                          */
#include "HW_Flash.h"       /* HW_Flash_Erase(), HW_Flash_Write() (via NvmErase/NvmWrite) */
#include "core_protocol.h"  /* Core_Protocol_Init(), Core_Protocol_Task()                  */
#include "core_backdoor.h"  /* Core_Backdoor_Check(), BACKDOOR_TIMEOUT, BACKDOOR_ACTIVE    */

/**
 * \brief   CPU0 bootloader main function.
 *
 *          Called by the iLLD startup code (IfxCpu_CStart.c) after the C runtime
 *          environment (BSS clear, data copy) has been initialized. The function
 *          never returns: it either jumps to the application or loops indefinitely
 *          serving XCP protocol commands.
 */
void core0_main(void)
{
    /* ------------------------------------------------------------------
     * 1. Disable ECC trap — MUST be first, before any App Flash access.
     *
     *    TC275 raises a Bus Error Trap (class 4) when the CPU reads a
     *    Flash page whose ECC bits are invalid (i.e. any never-programmed
     *    page). Setting FLASH0_MARP.B.TRAPDIS = 1 suppresses this trap.
     *    Required here because HW_CPU_Verify_App_Checksum() reads App
     *    Flash which may be blank on first boot.
     * ------------------------------------------------------------------ */
    HW_CPU_Disable_ECC_Trap();

    /* ------------------------------------------------------------------
     * 2. Hardware initialization (order is significant).
     *
     *    HW_System_Init(): Disables Safety WDT + CPU0 WDT (both expire
     *                      within ~3 ms if not serviced). Configures P00.5
     *                      as push-pull output for the LED heartbeat.
     *    HW_Timer_Init():  Calibrates STM0 ticks-per-ms so that
     *                      HW_Timer_GetMs() returns accurate values.
     *                      Must be called BEFORE HW_CAN_Init() because
     *                      Core_Backdoor_Check() uses HW_Timer_GetMs()
     *                      to measure the 3-second backdoor window.
     *    HW_CAN_Init():    Configures MultiCAN+ Module + Node 0 + two
     *                      Message Objects (RX 0x667, TX 0x7E1, 500 kbps).
     * ------------------------------------------------------------------ */
    HW_System_Init();
    HW_Timer_Init();
    HW_CAN_Init();

    /* ------------------------------------------------------------------
     * 3. XCP state machine initialization.
     *
     *    XcpInit() (called internally) resets xcpInfo: connected flag = 0,
     *    resource protection = fully locked, MTA = 0.
     *    MUST be called before Core_Backdoor_Check() because when the
     *    backdoor receives an XCP CONNECT packet it immediately calls
     *    XcpPacketReceived() — the state machine must be ready at that point.
     * ------------------------------------------------------------------ */
    Core_Protocol_Init();

    /* ------------------------------------------------------------------
     * 4. Backdoor window — 3-second polling period.
     *
     *    Polls HW_CAN_Receive() for an XCP CONNECT command (0xFF).
     *    BACKDOOR_ACTIVE  : CONNECT received; XcpPacketReceived() already
     *                       processed it; fall through to the protocol loop.
     *    BACKDOOR_TIMEOUT : No host in 3 s; verify App and jump if valid.
     * ------------------------------------------------------------------ */
    if (Core_Backdoor_Check() == BACKDOOR_TIMEOUT)
    {
        /* Verify the one's-complement checksum before jumping.
         * Prevents a jump into blank Flash (0xFF), which would cause
         * the CPU to fetch and execute 0xFFFFFFFF — an illegal opcode trap. */
        if (HW_CPU_Verify_App_Checksum() == BLT_TRUE)
        {
            /* Valid application: tear down peripherals and jump — no return. */
            HW_CPU_JumpToApp();
        }

        /* Invalid application (blank Flash or bad checksum):
         * fall through to the protocol loop and wait for MicroBoot to flash a new image. */
    }

    /* ------------------------------------------------------------------
     * 5. Main XCP protocol loop.
     *
     *    Core_Protocol_Task() is non-blocking:
     *      - Calls HW_CAN_Receive() once per iteration.
     *      - If a frame is available, dispatches it to XcpPacketReceived().
     *      - Returns immediately if no frame is available.
     *
     *    XCP command flow (handled by xcp.c):
     *      CONNECT       -> sets xcpInfo.connected = 1
     *      SET_MTA       -> stores target Flash address
     *      PROGRAM_CLEAR -> calls NvmErase() -> HW_Flash_Erase()
     *      PROGRAM       -> calls NvmWrite() -> page buffer -> HW_Flash_Write()
     *      PROGRAM_RESET -> calls CpuStartUserProgram() -> HW_CPU_JumpToApp()
     *
     * 6. LED heartbeat — non-blocking 100 ms toggle.
     *
     *    Uses a timer delta (HW_Timer_GetMs() - lastLedMs) instead of
     *    HW_Delay_ms() to avoid blocking Core_Protocol_Task().
     *    LED P00.5 blinking at 5 Hz signals "bootloader active".
     * ------------------------------------------------------------------ */
    uint32 lastLedMs = 0U;

    while (1)
    {
        Core_Protocol_Task();

        /* Toggle LED every 100 ms — unsigned subtraction is safe on STM0 wrap-around. */
        if ((HW_Timer_GetMs() - lastLedMs) >= 100U)
        {
            HW_LED_Toggle();
            lastLedMs = HW_Timer_GetMs();
        }
    }
}
