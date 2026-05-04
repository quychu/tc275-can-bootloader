/**
 * \file    HW_Flash.h
 * \brief   Hardware Abstraction Layer for TC275 Program Flash (PFlash).
 *
 *          Provides sector-erase and page-write operations over the PMU0
 *          Flash Command Sequence, executed from CPU0 PSPR (RAM) to avoid
 *          instruction-fetch stalls while the Flash bus is locked.
 *
 *          Architecture:
 *          \code
 *          HW_Flash (this file) --> iLLD IfxFlash (all IFX_INLINE) --> PMU0 hardware
 *          \endcode
 *
 * \note    Both HW_Flash_Erase() and HW_Flash_Write() are placed in the
 *          \c cpu0_psram linker section via \c _Pragma("section code cpu0_psram").
 *          Only IFX_INLINE functions may be called from within them; any
 *          call that fetches instructions from Flash will cause a CPU stall
 *          or bus error while the Flash is locked.
 */

#ifndef HARDWARE_LAYER_HW_FLASH_H_
#define HARDWARE_LAYER_HW_FLASH_H_

#include "Ifx_Types.h"

/** \brief TC275 PFlash minimal program unit in bytes (one page). */
#define HW_FLASH_PAGE_SIZE      (32U)

/** \brief Base address of the PFlash non-cached alias (used for erase/write). */
#define HW_FLASH_UNCACHED_BASE  (0xA0000000U)

/**
 * \brief   Erase one or more PFlash sectors starting at \p addr.
 *
 *          Runs from CPU0 PSPR (RAM). Uses only IFX_INLINE iLLD functions
 *          and the Safety EndInit Inline variants (clearSafetyEndinitInline /
 *          setSafetyEndinitInline) because the Flash bus is locked after the
 *          erase command is issued.
 *
 *          Optimization: the sector is pre-checked with eraseVerifySector()
 *          before issuing the erase command. If the sector is already blank,
 *          the erase is skipped to preserve Flash endurance.
 *
 * \param   addr    Sector-aligned base address in the non-cached Flash alias
 *                  (segment A, e.g. 0xA0008000).
 * \param   length  Number of sectors to erase.
 * \return  TRUE  on success (sector verified blank after erase).
 *          FALSE if SQER, PROER, or EVER is set in FLASH0_FSR.
 */
boolean HW_Flash_Erase(uint32 addr, uint32 length);

/**
 * \brief   Write data to PFlash in 32-byte page units.
 *
 *          Runs from CPU0 PSPR (RAM). For each 32-byte page:
 *            1. Pad partial pages with 0xFF (erased Flash state).
 *            2. Open Assembly Buffer (enterPageMode).
 *            3. Load 32 bytes in four 8-byte chunks (loadPage2X32).
 *            4. Commit page (writePage) under Safety EndInit Inline protection.
 *            5. Verify FLASH0_FSR for SQER / PROER / PVER errors.
 *
 * \param   addr    Page-aligned destination address in the non-cached Flash alias.
 * \param   data    Pointer to the source data buffer.
 * \param   length  Number of bytes to write (rounded up to the next 32-byte boundary).
 * \return  TRUE  on success.
 *          FALSE if any page write reports an FSR error.
 */
boolean HW_Flash_Write(uint32 addr, const uint8 *data, uint32 length);

#endif /* HARDWARE_LAYER_HW_FLASH_H_ */
