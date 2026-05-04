################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"../OpenBLT_Core/third_party/tinyusb/src/tusb.c" 

COMPILED_SRCS += \
"OpenBLT_Core/third_party/tinyusb/src/tusb.src" 

C_DEPS += \
"./OpenBLT_Core/third_party/tinyusb/src/tusb.d" 

OBJS += \
"OpenBLT_Core/third_party/tinyusb/src/tusb.o" 


# Each subdirectory must supply rules for building sources it contributes
"OpenBLT_Core/third_party/tinyusb/src/tusb.src":"../OpenBLT_Core/third_party/tinyusb/src/tusb.c" "OpenBLT_Core/third_party/tinyusb/src/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/tinyusb/src/tusb.o":"OpenBLT_Core/third_party/tinyusb/src/tusb.src" "OpenBLT_Core/third_party/tinyusb/src/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-OpenBLT_Core-2f-third_party-2f-tinyusb-2f-src

clean-OpenBLT_Core-2f-third_party-2f-tinyusb-2f-src:
	-$(RM) ./OpenBLT_Core/third_party/tinyusb/src/tusb.d ./OpenBLT_Core/third_party/tinyusb/src/tusb.o ./OpenBLT_Core/third_party/tinyusb/src/tusb.src

.PHONY: clean-OpenBLT_Core-2f-third_party-2f-tinyusb-2f-src

