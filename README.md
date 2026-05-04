# TC275 CAN Bootloader

A custom bootloader for the **Infineon AURIX TC275 D-Step** microcontroller, built on top of **OpenBLT** with a fully custom Hardware Abstraction Layer (HAL). Supports in-field firmware updates over CAN bus using the **XCP protocol**, with a Python-based GUI flash tool.

---

## Features

- **XCP over CAN** firmware update (500 kbps, no MicroBoot GUI required)
- **UDS SecurityAccess (0x27)** — seed/key authentication before flash
- **PFlash sector management** — erase/write with ECC trap handling and boundary checks
- **JumpToApp** with OpenBLT checksum verification (`CHECKSUM_OFFSET = 0x3C`)
- **GUI Flash Tool** (`TC275_Flasher.exe`) — supports `.hex` auto-patch → `.srec` → flash in one click
- AUTOSAR-style layered architecture: `Application ↔ Hardware_Layer ↔ Core_OpenBLT ↔ iLLD`

---

## Repository Structure

```
tc275-can-bootloader/
├── bootloader/                  # Bootloader source (AURIX TC275)
│   ├── Application/             # Main application layer, app_config.h
│   ├── Hardware_Layer/          # Custom HAL: HW_CAN, HW_Flash, HW_System, HW_CPU
│   ├── Core_OpenBLT/            # XCP protocol core + Backdoor logic (trimmed from OpenBLT)
│   ├── Configuration/           # Linker script: Bootloader_TC275.lsl
│   ├── Configurations/          # Build configurations (TASKING)
│   ├── Libraries/               # Infineon iLLD TC27D (read-only)
│   ├── Documents/               # Reference PDFs
│   └── example_bootloaderOpenBTL/  # OpenBLT reference port (TRICORE_TC2)
├── dummy-app/                   # Minimal test application (LED blink) for flash verification
├── tools/
│   └── TC275_Flasher.exe        # GUI flash tool (Windows)
└── README.md
```

---

## Hardware

| Item | Detail |
|------|--------|
| MCU | Infineon AURIX TC275 D-Step (TriCore 1.6P, 3 cores @ 200 MHz) |
| Flash | 4 MB PFlash (PMU0) |
| Bootloader region | S0 + S1 — `0xA0000000` – `0xA0007FFF` (32 KB) |
| Application region | S2+ — starts at `0xA0008000` |
| CAN adapter | STM32 Virtual COM (SLCAN) on COM6 |
| Toolchain | TASKING VX-toolset for TriCore v6.3r1 + AURIX Development Studio |

---

## CAN Configuration

| Parameter | Value |
|-----------|-------|
| Baudrate | 500 kbps |
| PC → TC275 (TX ID) | `0x667` |
| TC275 → PC (RX ID) | `0x7E1` |
| Acceptance mask | `0x7FF` |

---

## Flash Flow

```
[1] Build Bootloader in ADS  →  flash via JTAG
[2] Build Dummy App in ADS
[3] TC275_Flasher.exe:
      Browse → select TC275_DUMMY_APP.hex
      → auto patch checksum (offset 0x3C)
      → auto convert to .srec
      → XCP CONNECT → PROGRAM_START
      → Erase sectors → Program segments
      → PROGRAM_RESET → App runs
[4] LED: 100ms (bootloader 3s window) → 1s (App) ✅
```

### XCP Command Sequence

```
XCP CONNECT        (0xFF)
PROGRAM_START      (0xD2)
SET_MTA + PROGRAM_CLEAR  (0xF6 + 0xD1)  ← OpenBLT custom, not XCP standard 0xD4
SET_MTA + PROGRAM  (0xF6 + 0xD0) × N    ← 6 bytes/frame
PROGRAM N=0        (flush page buffer)
PROGRAM_RESET      (0xCF)
```

---

## Getting Started

### Prerequisites

```
- AURIX Development Studio (ADS) with TASKING TriCore toolchain
- Python 3.8+ with python-can: pip install python-can
- STM32-based SLCAN adapter (or compatible CAN-USB)
```

### Build & Flash Bootloader

1. Open ADS → Import project from `bootloader/`
2. Build (`Ctrl+B`) → flash via JTAG debug session
3. Terminate debug session — board now runs bootloader

### Flash Application via GUI

1. Run `tools/TC275_Flasher.exe`
2. Browse and select the application `.hex` file
3. Set COM port (default: `COM6`) and baudrate (`500000`)
4. Press **Reset** on the TC275 board, then click **Start**
5. The tool auto-patches the OpenBLT checksum and flashes over CAN

### Flash Application via Python (CLI)

```bash
# Install dependency
pip install python-can

# Flash
python xcp_flash.py "path/to/TC275_DUMMY_APP_patched.srec"
```

---

## Architecture

```
┌─────────────────────────────────────────────┐
│              Application Layer              │
│         (core0_main, app_config.h)          │
├─────────────────────────────────────────────┤
│              Core_OpenBLT Layer             │
│     (XCP protocol, Backdoor, flash.c)       │
├─────────────────────────────────────────────┤
│            Hardware_Layer (HAL)             │
│    HW_CAN | HW_Flash | HW_System | HW_CPU  │
├─────────────────────────────────────────────┤
│          Infineon iLLD TC27D (MCAL)         │
│    IfxMultican | IfxFlash | IfxScuWdt ...   │
└─────────────────────────────────────────────┘
              Infineon AURIX TC275
```

**Multi-core strategy:** All bootloader logic runs on **CPU0**. CPU1 and CPU2 disable their watchdogs and enter `while(1)` idle — no sync events used in boot flow.

---

## Key Technical Notes

- `CHECKSUM_OFFSET = 0x3C` — TC275 TriCore has no ARM vector table; 7 words at App start are blank (`0xFFFFFFFF`). OpenBLT `flash.c` defines `BOOT_FLASH_VECTOR_TABLE_CS_OFFSET = 0x3C`.
- Flash write/erase uses **non-cached segment** (`0xA000_0000`) to avoid stale D-cache.
- `FLASH0_MARP.B.TRAPDIS = 1` before checksum verification to suppress ECC Bus Error trap on unwritten pages.
- `HW_CAN_DeInit()` is called before `JumpToApp` to avoid ISR vector mismatch in the application.
- Functions executing during Flash lock must be `IFX_INLINE` (linked to RAM) to avoid `contextManagementError` trap.

---

## Lessons Learned

| Issue | Root Cause | Fix |
|-------|-----------|-----|
| JumpToApp never executed (LED stuck at 100ms) | `CHECKSUM_OFFSET` was `0x1C` (ARM assumption) | Changed to `0x3C` per OpenBLT `flash.c` |
| `IfxStm_getFrequency()` returns 0 in App | STM not re-initialized after JumpToApp | Hardcoded `100000000UL` or use software delay loop |
| MicroBoot GUI fails with SLCAN adapter | GUI doesn't handle Lawicel/SLCAN protocol correctly | Replaced with custom `xcp_flash.py` using `python-can` |
| Undefined behavior on CAN traffic in App | MultiCAN+ still active when App starts | Added `HW_CAN_DeInit()` before jump |

---

## License

Bootloader core based on [OpenBLT](https://www.feaser.com/openblt/) — Boost Software License 1.0.  
iLLD library © Infineon Technologies AG — read-only, unmodified.
