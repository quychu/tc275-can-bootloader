################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"../OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.c" \
"../OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.c" 

COMPILED_SRCS += \
"OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.src" \
"OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.src" 

C_DEPS += \
"./OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.d" \
"./OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.d" 

OBJS += \
"OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.o" \
"OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.o" 


# Each subdirectory must supply rules for building sources it contributes
"OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.src":"../OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.c" "OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.o":"OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.src" "OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.src":"../OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.c" "OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.o":"OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.src" "OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-OpenBLT_Core-2f-third_party-2f-tinyusb-2f-src-2f-portable-2f-synopsys-2f-dwc2

clean-OpenBLT_Core-2f-third_party-2f-tinyusb-2f-src-2f-portable-2f-synopsys-2f-dwc2:
	-$(RM) ./OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.d ./OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.o ./OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dcd_dwc2.src ./OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.d ./OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.o ./OpenBLT_Core/third_party/tinyusb/src/portable/synopsys/dwc2/dwc2_common.src

.PHONY: clean-OpenBLT_Core-2f-third_party-2f-tinyusb-2f-src-2f-portable-2f-synopsys-2f-dwc2

