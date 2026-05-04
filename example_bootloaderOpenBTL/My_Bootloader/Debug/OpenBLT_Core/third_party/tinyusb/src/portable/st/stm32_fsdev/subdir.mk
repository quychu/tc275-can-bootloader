################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"../OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.c" 

COMPILED_SRCS += \
"OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.src" 

C_DEPS += \
"./OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.d" 

OBJS += \
"OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.o" 


# Each subdirectory must supply rules for building sources it contributes
"OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.src":"../OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.c" "OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.o":"OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.src" "OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-OpenBLT_Core-2f-third_party-2f-tinyusb-2f-src-2f-portable-2f-st-2f-stm32_fsdev

clean-OpenBLT_Core-2f-third_party-2f-tinyusb-2f-src-2f-portable-2f-st-2f-stm32_fsdev:
	-$(RM) ./OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.d ./OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.o ./OpenBLT_Core/third_party/tinyusb/src/portable/st/stm32_fsdev/dcd_stm32_fsdev.src

.PHONY: clean-OpenBLT_Core-2f-third_party-2f-tinyusb-2f-src-2f-portable-2f-st-2f-stm32_fsdev

