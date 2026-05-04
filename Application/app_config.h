/**
 * \file    app_config.h
 * \brief   Central configuration header for the TC275 custom bootloader.
 *
 *          All magic numbers (CAN IDs, Flash addresses, timeouts) are defined
 *          here so that they appear in exactly one place. Source files include
 *          this header instead of embedding literal constants in their logic.
 *
 * \note    Changing any address macro here must be reflected in the linker
 *          script (Bootloader_TC275.lsl) and vice versa to keep them consistent.
 */

#ifndef APPLICATION_APP_CONFIG_H_
#define APPLICATION_APP_CONFIG_H_

/*============================================================================
 * CAN Configuration
 *===========================================================================*/

/** \brief CAN bus baud rate in bits per second. */
#define BOOT_COM_CAN_BAUDRATE       500000U

/**
 * \brief   CAN message ID used for bootloader-to-host (TX) frames.
 *
 *          Value 0x7E1 follows the OpenBLT / MicroBoot convention for the
 *          response message identifier.
 */
#define BOOT_COM_CAN_TX_MSG_ID      0x7E1U

/**
 * \brief   CAN message ID used for host-to-bootloader (RX) frames.
 *
 *          Value 0x667 is the complementary command identifier expected
 *          by MicroBoot when communicating with OpenBLT over CAN.
 */
#define BOOT_COM_CAN_RX_MSG_ID      0x667U

/*============================================================================
 * Backdoor Timeout
 *===========================================================================*/

/**
 * \brief   Time window (ms) during which the bootloader waits for an XCP
 *          CONNECT command from a host (MicroBoot) before jumping to the app.
 *
 *          Increase this value if the host PC needs more time to start up.
 *          Decrease it for faster production boot times.
 */
#define BACKDOOR_TIMEOUT_MS         3000U

/*============================================================================
 * Application Flash Addresses
 *===========================================================================*/

/**
 * \brief TC275 PFlash dual-alias address map:
 *
 *   Segment 8 (0x8xxx xxxx) — CACHED   : used to execute code (via PCache).
 *   Segment A (0xAxxx xxxx) — NON-CACHED: used for erase and write operations.
 *   Both aliases map to the same physical Flash cells.
 *
 *   Bootloader occupies PFlash sectors S0 + S1 (2 × 16 KB = 32 KB):
 *     0x80000000 – 0x80007FFF  (cached)
 *     0xA0000000 – 0xA0007FFF  (non-cached)
 *
 *   Application starts at sector S2:
 *     0x80008000 (cached)  / 0xA0008000 (non-cached)
 */

/** \brief Cached start address of App Flash — used for checksum verification reads. */
#define APP_FLASH_START_CACHED      (0x80008000UL)

/**
 * \brief   Application entry point (cached alias).
 *
 *          The first 32 bytes (0x00–0x1F) of the App Flash region are reserved
 *          for the OpenBLT checksum area. The application's startup code begins
 *          at byte offset 0x20 from APP_FLASH_START_CACHED.
 */
#define APP_FLASH_ENTRY_POINT       (0x80008020UL)

/**
 * \brief   Byte offset from APP_FLASH_START_CACHED where OpenBLT stores the
 *          one's-complement checksum word.
 *
 *          TC275 TriCore does not use an ARM-style interrupt vector table at
 *          the start of the Flash image. OpenBLT reads 7 words from offsets
 *          0x00–0x18 (all 0xFF when blank), computes their one's complement,
 *          and writes the checksum at offset 0x3C (not 0x1C as on ARM targets).
 *          Source reference: BOOT_FLASH_VECTOR_TABLE_CS_OFFSET in OpenBLT flash.c.
 */
#define APP_CHECKSUM_OFFSET         (0x3CUL)

/**
 * \brief   Number of 32-bit words included in the checksum calculation.
 *
 *          Words at byte offsets 0x00, 0x04, 0x08, 0x0C, 0x10, 0x14, 0x18
 *          (7 words × 4 bytes = 28 bytes) are summed; the result is
 *          one's-complemented and stored at APP_CHECKSUM_OFFSET.
 */
#define APP_VECTOR_COUNT            (7U)

#endif /* APPLICATION_APP_CONFIG_H_ */
