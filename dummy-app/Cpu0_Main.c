#include "Ifx_Types.h"
#include "IfxCpu.h"
#include "IfxScuWdt.h"
#include "IfxPort.h"
#include "Bsp.h"   /* Include this header to use the standard STM delay function */

/*--------------------------------------------------------------------------------------------------------------------
 * OpenBLT Checksum Placeholder at offset 0x3C (Physical address: 0x8000803C).
 *
 * - The linker places these 4 bytes into the .rodata.openblt_checksum section (matching
 *   the app_checksum group in the LSL file) -> reserving space at exactly 0x8000803C.
 * - The value 0xFFFFFFFF is merely a placeholder. The patch_checksum.py script will calculate
 *   the actual checksum and overwrite these 4 bytes before flashing via MicroBoot.
 * - volatile: Prevents the compiler/linker from optimizing out this "unused" variable.
 *------------------------------------------------------------------------------------------------------------------*/
#pragma section farrom "openblt_checksum"
volatile const uint32 App_Checksum = 0xFFFFFFFFU;
#pragma section farrom restore

/* LED P00.5 Configuration */
#define APP_LED_PORT    (&MODULE_P00)
#define APP_LED_PIN     (5U)
#define WAIT_TIME       1000U   /* Delay time in milliseconds (1000 = 1 second) */

void core0_main(void)
{
    /* 1. DISABLE GLOBAL INTERRUPTS IMMEDIATELY: Block any pending interrupts left by the Bootloader */
    IfxCpu_disableInterrupts();

    /* 2. DISABLE WATCHDOGS */
    IfxScuWdt_disableCpuWatchdog(IfxScuWdt_getCpuWatchdogPassword());
    IfxScuWdt_disableSafetyWatchdog(IfxScuWdt_getSafetyWatchdogPassword());

    /* 3. INITIALIZE LED P00.5 */
    IfxPort_setPinModeOutput(APP_LED_PORT, APP_LED_PIN, IfxPort_OutputMode_pushPull, IfxPort_OutputIdx_general);

    /* Force the LED off initially (Active Low -> Setting High turns it off) */
    IfxPort_setPinHigh(APP_LED_PORT, APP_LED_PIN);

    /* 4. MAIN LOOP */
    while (1)
    {
        /* Toggle the state of LED P00.5 */
        IfxPort_togglePin(APP_LED_PORT, APP_LED_PIN);

        /* Use the standard iLLD wait function based on the STM hardware timer */
        waitTime(IfxStm_getTicksFromMilliseconds(BSP_DEFAULT_TIMER, WAIT_TIME));
    }
}
