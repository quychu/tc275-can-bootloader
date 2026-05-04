/**
 * \file    HW_CPU.c
 * \brief   Hardware Abstraction Layer — CPU-level operations for the TC275 bootloader.
 *
 *          Implements ECC trap control, application checksum verification, and
 *          the jump-to-application sequence. All register accesses that require
 *          EndInit protection follow the standard TC275 pattern:
 *          \code
 *          password = IfxScuWdt_getCpuWatchdogPassword();
 *          IfxScuWdt_clearCpuEndinit(password);
 *          <write EndInit-protected register>
 *          IfxScuWdt_setCpuEndinit(password);
 *          \endcode
 */

#include "HW_CPU.h"
#include "IfxFlash.h"           /* FLASH0_MARP register definition              */
#include "IfxScuWdt.h"          /* CPU EndInit: getCpuWatchdogPassword / clear / set */
#include "IfxCpu_Intrinsics.h"  /* Ifx__jumpToFunction (TASKING compiler intrinsic)  */
#include "app_config.h"         /* APP_FLASH_START_CACHED, APP_FLASH_ENTRY_POINT,
                                   APP_CHECKSUM_OFFSET, APP_VECTOR_COUNT          */
#include "HW_CAN.h"             /* HW_CAN_DeInit()                               */

/**
 * \brief   Disable the Flash ECC uncorrectable-bit-error trap.
 *
 *          Writes FLASH0_MARP.B.TRAPDIS = 1 under CPU EndInit protection.
 *
 *          Background: TC275 PFlash ECC is computed per 128-bit quad-word.
 *          A page that has never been programmed contains undefined ECC bits.
 *          When the CPU reads such a page, the Flash controller detects an ECC
 *          error and signals a Bus Error Trap (class 4, dataAccessSynchronousError).
 *          Setting TRAPDIS = 1 prevents the trap; the read still returns the
 *          (undefined) data but the CPU continues execution normally.
 *
 * \note    Must be called as the first statement in core0_main(), before any
 *          access to App Flash (checksum read, blank-flash check).
 */
void HW_CPU_Disable_ECC_Trap(void)
{
    uint16 password = IfxScuWdt_getCpuWatchdogPassword();
    IfxScuWdt_clearCpuEndinit(password);

    FLASH0_MARP.B.TRAPDIS = 1;   /* Suppress ECC uncorrectable-bit-error trap. */

    IfxScuWdt_setCpuEndinit(password);
}

/**
 * \brief   Re-enable the Flash ECC uncorrectable-bit-error trap.
 *
 *          Writes FLASH0_MARP.B.TRAPDIS = 0 under CPU EndInit protection,
 *          restoring the power-on default. Called by HW_CPU_JumpToApp() so that
 *          the application inherits the expected ECC protection state.
 */
void HW_CPU_Enable_ECC_Trap(void)
{
    uint16 password = IfxScuWdt_getCpuWatchdogPassword();
    IfxScuWdt_clearCpuEndinit(password);

    FLASH0_MARP.B.TRAPDIS = 0;   /* Restore default ECC trap (enabled). */

    IfxScuWdt_setCpuEndinit(password);
}

/**
 * \brief   Verify the application firmware using a one's-complement checksum.
 *
 *          Algorithm:
 *            sum    = sum of APP_VECTOR_COUNT (7) 32-bit words starting at
 *                     APP_FLASH_START_CACHED (cached segment, safe to execute from).
 *            stored = 32-bit word at APP_FLASH_START_CACHED + APP_CHECKSUM_OFFSET (0x3C).
 *            valid  = (sum + stored) == 0xFFFFFFFF.
 *
 *          OpenBLT for TC275 TriCore places the checksum at byte offset 0x3C,
 *          not 0x1C as used on ARM targets. This is because TC275 does not have
 *          an ARM-style interrupt vector table at the start of the image; the
 *          first 0x20 bytes (32 bytes) are blank (0xFF) when the image is new,
 *          and the actual entry instruction begins at offset 0x20.
 *
 *          When Flash is blank, the 7 words are all 0xFFFFFFFF:
 *            sum    = 7 * 0xFFFFFFFF = 0xFFFFFF06  (32-bit wrap)
 *            stored = 0xFFFFFFFF (blank)
 *            sum + stored = 0xFFFFFF05 != 0xFFFFFFFF  =>  BLT_FALSE (stay in BL)
 *
 * \return  BLT_TRUE  if checksum is valid (application can be executed).
 *          BLT_FALSE if Flash is blank or checksum mismatch (remain in bootloader).
 */
blt_bool HW_CPU_Verify_App_Checksum(void)
{
    uint32 sum = 0U;
    uint8  i;

    /* Read APP_VECTOR_COUNT words from the cached App Flash alias. */
    for (i = 0U; i < APP_VECTOR_COUNT; i++)
    {
        sum += *((volatile uint32 *)(APP_FLASH_START_CACHED + (uint32)(i * 4U)));
    }

    /* Read the stored one's-complement checksum word. */
    uint32 stored = *((volatile uint32 *)(APP_FLASH_START_CACHED + APP_CHECKSUM_OFFSET));

    return ((sum + stored) == 0xFFFFFFFFUL) ? BLT_TRUE : BLT_FALSE;
}

/**
 * \brief   Tear down bootloader resources and jump to the application.
 *
 *          This function does NOT return.
 *
 *          Cleanup order (must not be changed):
 *            1. HW_CAN_DeInit():          Clock-gates MultiCAN+ so no pending CAN
 *                                         interrupt can fire into the bootloader's
 *                                         ISR table while the application initializes.
 *            2. HW_CPU_Enable_ECC_Trap(): Restores FLASH0_MARP.B.TRAPDIS = 0 so the
 *                                         application receives ECC protection by default.
 *            3. Ifx__jumpToFunction():    TASKING intrinsic that emits an indirect jump
 *                                         (JI A[x]) to APP_FLASH_ENTRY_POINT.
 *                                         The cached alias (0x80008020) is used so that
 *                                         the CPU instruction PCache is active.
 *
 * \note    CPU1 and CPU2 are NOT redirected here. They remain in their idle loops
 *          (core1_main / core2_main) until the application releases them.
 */
void HW_CPU_JumpToApp(void)
{
    /* Step 1: Disable CAN before App re-initializes it. */
    HW_CAN_DeInit();

    /* Step 2: Restore ECC protection for the application. */
    HW_CPU_Enable_ECC_Trap();

    /* Step 3: Jump — does not return. */
    Ifx__jumpToFunction((void *)APP_FLASH_ENTRY_POINT);
}
