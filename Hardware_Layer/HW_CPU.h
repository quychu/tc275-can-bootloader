/**
 * \file    HW_CPU.h
 * \brief   Hardware Abstraction Layer for CPU-level operations.
 *
 *          Provides three services used by the TC275 custom bootloader:
 *            1. ECC trap management  — suppress Flash ECC errors during blank-Flash reads.
 *            2. Application checksum verification — one's complement check before jump.
 *            3. Jump-to-application — orderly teardown then branch to App entry point.
 *
 *          Architecture:
 *          \code
 *          HW_CPU (this file) --> iLLD IfxScuWdt / IfxFlash_reg / IfxCpu_Intrinsics --> SCU / PMU0 HW
 *          \endcode
 *
 *          Recommended call order in core0_main():
 *          \code
 *          HW_CPU_Disable_ECC_Trap();       // Step 1: before any Flash read
 *          ...
 *          HW_CPU_Verify_App_Checksum();    // Step 2: after backdoor timeout
 *          HW_CPU_JumpToApp();              // Step 3: when App is valid
 *          \endcode
 */

#ifndef HARDWARE_LAYER_HW_CPU_H_
#define HARDWARE_LAYER_HW_CPU_H_

#include "xcp_port.h"   /* blt_bool, BLT_TRUE, BLT_FALSE */

/**
 * \brief   Disable the Flash ECC uncorrectable-bit-error trap.
 *
 *          Sets FLASH0_MARP.B.TRAPDIS = 1 under CPU EndInit protection
 *          (clearCpuEndinit / setCpuEndinit).
 *
 *          TC275 raises a synchronous Bus Error Trap (dataAccessSynchronousError)
 *          when the CPU reads a Flash page that has never been programmed
 *          (raw erased state — ECC check bits are invalid). The bootloader
 *          must read App Flash to verify the checksum, so this trap must be
 *          suppressed before any App Flash access occurs.
 *
 * \note    Call this as the very first statement in core0_main(), before
 *          HW_System_Init() and any other Flash read.
 */
void HW_CPU_Disable_ECC_Trap(void);

/**
 * \brief   Re-enable the Flash ECC uncorrectable-bit-error trap.
 *
 *          Sets FLASH0_MARP.B.TRAPDIS = 0 under CPU EndInit protection.
 *          Called internally by HW_CPU_JumpToApp() to restore the default
 *          Flash protection before the application takes over, since the
 *          application expects ECC trapping to be active.
 */
void HW_CPU_Enable_ECC_Trap(void);

/**
 * \brief   Verify the application firmware using a one's-complement checksum.
 *
 *          Reads 7 words (0x00–0x18) from the beginning of App Flash
 *          (cached alias, APP_FLASH_START_CACHED) and computes their sum.
 *          The stored checksum word at offset APP_CHECKSUM_OFFSET (0x3C)
 *          is the one's complement of that sum:
 *          \code
 *          sum(vector[0..6]) + stored_checksum == 0xFFFFFFFF  =>  valid
 *          \endcode
 *
 *          TC275 TriCore does not have an ARM-style interrupt vector table.
 *          OpenBLT stores the checksum at byte offset 0x3C (not 0x1C as on ARM).
 *          When Flash is blank (all 0xFF), the sum is 0xFFFFFF06 and the
 *          stored word is also 0xFF — the check fails and the bootloader
 *          stays resident.
 *
 * \pre     HW_CPU_Disable_ECC_Trap() must have been called first; otherwise
 *          reading blank Flash pages raises a Bus Error Trap.
 *
 * \return  BLT_TRUE  if the computed sum plus stored checksum equals 0xFFFFFFFF.
 *          BLT_FALSE if Flash is blank or the checksum is incorrect.
 */
blt_bool HW_CPU_Verify_App_Checksum(void);

/**
 * \brief   Tear down bootloader resources and branch to the application.
 *
 *          This function does NOT return.
 *
 *          Cleanup sequence (order is mandatory):
 *            1. HW_CAN_DeInit()         — Disable MultiCAN+ before App re-initializes
 *                                         CAN with its own ISR vector table.
 *            2. HW_CPU_Enable_ECC_Trap() — Restore FLASH0_MARP.B.TRAPDIS = 0 so the
 *                                         application receives default ECC protection.
 *            3. Ifx__jumpToFunction()   — Fetch and execute the first instruction at
 *                                         APP_FLASH_ENTRY_POINT (cached alias 0x80008020)
 *                                         so the CPU instruction cache (PCache) is used.
 *
 * \note    Only CPU0 jumps to the application. CPU1 and CPU2 remain in their
 *          respective idle loops (core1_main / core2_main) until the application
 *          releases them via its own startup sequence.
 */
void HW_CPU_JumpToApp(void);

#endif /* HARDWARE_LAYER_HW_CPU_H_ */
