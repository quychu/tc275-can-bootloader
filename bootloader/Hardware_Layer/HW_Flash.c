/**
 * \file    HW_Flash.c
 * \brief   Hardware Abstraction Layer — TC275 PFlash erase and write driver.
 *
 *          Implements the TC275 Flash Command Sequence for sector erase and
 *          page-by-page programming via the PMU0 peripheral. Both functions
 *          run from CPU0 PSPR (Program Scratch-Pad RAM) to avoid instruction-fetch
 *          stalls while the Flash bus is locked during erase/write operations.
 *
 *          Architecture:
 *          \code
 *          HW_Flash (this file) --> iLLD IfxFlash (IFX_INLINE) --> PMU0 hardware
 *          \endcode
 *
 * \attention  RAM-execution constraint:
 *             Both functions are placed in the \c cpu0_psram linker section via
 *             \c _Pragma("section code cpu0_psram"). Every function they call
 *             MUST be IFX_INLINE; any call that fetches from Flash will cause a
 *             CPU stall or bus error while the Flash bus is locked.
 *
 *             Safe calls inside RAM functions:
 *               - IfxFlash_*  : all IFX_INLINE in IfxFlash.h  => OK
 *               - IfxScuWdt_clearSafetyEndinitInline()         => OK  (Inline variant)
 *               - IfxScuWdt_setSafetyEndinitInline()           => OK  (Inline variant)
 *               - IfxScuWdt_getSafetyWatchdogPasswordInline()  => OK  (Inline variant)
 *
 *             Unsafe (must NOT be called from RAM functions):
 *               - IfxScuWdt_clearSafetyEndinit()  — not inline, resides in Flash => STALL
 */

#include "HW_Flash.h"
#include "IfxFlash.h"    /* Flash APIs (all IFX_INLINE) + IfxFlash_reg.h (FLASH0_FSR) */
#include "IfxScuWdt.h"   /* Safety EndInit Inline variants                             */

/**
 * \brief   Erase one or more PFlash sectors.
 *
 *          Execution context: CPU0 PSPR (RAM).
 *
 *          Algorithm:
 *            1. Clear FLASH0_FSR sticky flags.
 *            2. Run eraseVerifySector() + waitUnbusyAll() — skip the actual erase
 *               if the sector is already blank (preserves Flash endurance).
 *            3. If not blank: clear FSR again (sticky EVER from step 2 must be
 *               cleared before the real erase or the post-erase check will fail).
 *            4. Unlock Safety EndInit (Inline), issue eraseSector(), re-lock (Inline).
 *            5. Wait for PMU0 idle (waitUnbusyAll).
 *            6. Check FLASH0_FSR for SQER / PROER / EVER error flags.
 *
 * \param   addr    Sector-aligned base address in the non-cached Flash alias
 *                  (segment A, e.g. 0xA0008000). Must be at an exact sector boundary.
 * \param   length  Number of sectors to erase.
 * \return  TRUE  on success (sector blank after erase or already blank).
 *          FALSE if SQER, PROER, or EVER is set in FLASH0_FSR.
 */
_Pragma("section code cpu0_psram")
boolean HW_Flash_Erase(uint32 addr, uint32 length)
{
    uint16 password;

    /* 1. Clear sticky FSR flags from any previous operation. */
    IfxFlash_clearStatus(0);

    /* 2. Pre-check: verify the sector is already blank.
     *    If SQER == 0 and EVER == 0 after verifying, the sector is already erased
     *    and we can exit early without consuming a Flash erase cycle. */
    IfxFlash_eraseVerifySector(addr);
    IfxFlash_waitUnbusyAll();

    if ((FLASH0_FSR.B.SQER == 0) && (FLASH0_FSR.B.EVER == 0))
    {
        return TRUE;    /* Sector already blank — skip erase. */
    }

    /* 3. Clear FSR again before the real erase.
     *    FLASH0_FSR is a sticky register: EVER set by eraseVerifySector() (step 2)
     *    remains set. If not cleared here, the post-erase FSR check (step 6) would
     *    read the stale EVER=1 and incorrectly return FALSE. */
    IfxFlash_clearStatus(0);

    /* 4. Issue the erase command under Safety EndInit protection.
     *    All three calls must use the Inline variants:
     *      - clearSafetyEndinitInline: Flash is not yet locked here => safe.
     *      - eraseSector: issues the Flash Command Sequence; Flash LOCKS immediately after.
     *      - setSafetyEndinitInline: IFX_INLINE => does not fetch from Flash => safe. */
    password = IfxScuWdt_getSafetyWatchdogPasswordInline();
    IfxScuWdt_clearSafetyEndinitInline(password);
    IfxFlash_eraseSector(addr);
    IfxScuWdt_setSafetyEndinitInline(password);

    /* 5. Wait for PMU0 to complete the erase (polls FSR.PBUSY). */
    IfxFlash_waitUnbusyAll();

    /* 6. Verify: check error flags in FLASH0_FSR.
     *    SQER  = sequence error (address not sector-aligned)
     *    PROER = protection error (sector is write-protected)
     *    EVER  = erase verify error (cells did not return to 0xFF) */
    if ((FLASH0_FSR.B.SQER  != 0) ||
        (FLASH0_FSR.B.PROER != 0) ||
        (FLASH0_FSR.B.EVER  != 0))
    {
        return FALSE;
    }

    return TRUE;
}
_Pragma("section code restore")


/**
 * \brief   Write data to PFlash in 32-byte page units.
 *
 *          Execution context: CPU0 PSPR (RAM).
 *
 *          The TC275 Flash minimal program unit is one page = 32 bytes.
 *          For each page:
 *            A. Assemble a 32-byte page buffer from \p data; pad remainder with 0xFF.
 *            B. Clear FLASH0_FSR sticky flags.
 *            C. Open the Assembly Buffer (enterPageMode + waitUnbusyAll).
 *            D. Load 32 bytes into the Assembly Buffer in four 8-byte chunks
 *               (loadPage2X32 × 4); the PMU0 auto-increments the write pointer.
 *            E. Commit the page under Safety EndInit Inline protection (writePage).
 *            F. Wait for PMU0 idle.
 *            G. Check FLASH0_FSR for SQER / PROER / PVER errors.
 *            H. Advance \p addr and \p data pointers by HW_FLASH_PAGE_SIZE.
 *
 * \param   addr    Page-aligned start address in the non-cached Flash alias (segment A).
 * \param   data    Pointer to the source data buffer.
 * \param   length  Number of bytes to write (rounded up to next 32-byte boundary).
 * \return  TRUE  on success.
 *          FALSE if any page write sets SQER, PROER, or PVER in FLASH0_FSR.
 */
_Pragma("section code cpu0_psram")
boolean HW_Flash_Write(uint32 addr, const uint8 *data, uint32 length)
{
    uint16  password;
    uint32  numPages;
    uint32  pageIdx;
    uint8   pageBuf[HW_FLASH_PAGE_SIZE];   /* 32-byte page buffer on DSPR stack. */
    uint32  byteIdx;
    uint32  bytesThisPage;
    uint32 *wordPtr;

    /* Round up to the number of full 32-byte pages required. */
    numPages = (length + HW_FLASH_PAGE_SIZE - 1U) / HW_FLASH_PAGE_SIZE;

    for (pageIdx = 0U; pageIdx < numPages; pageIdx++)
    {
        /* A. Build the page buffer.
         *    Copy the data bytes for this page, then pad the remainder with 0xFF
         *    (the erased Flash state — writing 0xFF to an erased cell is a no-op). */
        bytesThisPage = length - (pageIdx * HW_FLASH_PAGE_SIZE);
        if (bytesThisPage > HW_FLASH_PAGE_SIZE)
        {
            bytesThisPage = HW_FLASH_PAGE_SIZE;
        }
        for (byteIdx = 0U; byteIdx < bytesThisPage; byteIdx++)
        {
            pageBuf[byteIdx] = data[byteIdx];
        }
        for (byteIdx = bytesThisPage; byteIdx < HW_FLASH_PAGE_SIZE; byteIdx++)
        {
            pageBuf[byteIdx] = 0xFFU;
        }

        /* B. Clear sticky FSR flags before each page write. */
        IfxFlash_clearStatus(0);

        /* C. Open Assembly Buffer — mandatory before loadPage2X32(). */
        IfxFlash_enterPageMode(addr);
        IfxFlash_waitUnbusyAll();

        /* D. Load 32 bytes in four 8-byte chunks.
         *    Cast uint8* to uint32* to read 4 bytes at a time.
         *    PMU0 auto-increments the Assembly Buffer write pointer after each call. */
        wordPtr = (uint32 *)pageBuf;
        IfxFlash_loadPage2X32(addr, wordPtr[0], wordPtr[1]); /* bytes  0– 7 */
        IfxFlash_loadPage2X32(addr, wordPtr[2], wordPtr[3]); /* bytes  8–15 */
        IfxFlash_loadPage2X32(addr, wordPtr[4], wordPtr[5]); /* bytes 16–23 */
        IfxFlash_loadPage2X32(addr, wordPtr[6], wordPtr[7]); /* bytes 24–31 */

        /* E. Commit the page under Safety EndInit Inline protection.
         *    Flash LOCKS immediately after writePage(); the setSafetyEndinit
         *    Inline variant does not fetch from Flash and is therefore safe. */
        password = IfxScuWdt_getSafetyWatchdogPasswordInline();
        IfxScuWdt_clearSafetyEndinitInline(password);
        IfxFlash_writePage(addr);
        IfxScuWdt_setSafetyEndinitInline(password);

        /* F. Wait for PMU0 to complete the page write. */
        IfxFlash_waitUnbusyAll();

        /* G. Check error flags.
         *    PVER = Program Verify Error (cell did not retain the written value).
         *           Distinct from EVER (Erase Verify Error). */
        if ((FLASH0_FSR.B.SQER  != 0) ||
            (FLASH0_FSR.B.PROER != 0) ||
            (FLASH0_FSR.B.PVER  != 0))
        {
            return FALSE;
        }

        /* H. Advance to the next page. */
        addr += HW_FLASH_PAGE_SIZE;
        data += HW_FLASH_PAGE_SIZE;
    }

    return TRUE;
}
_Pragma("section code restore")
