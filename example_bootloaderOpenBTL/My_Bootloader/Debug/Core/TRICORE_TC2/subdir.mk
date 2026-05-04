################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"D:/Project/openblt-master/Target/Source/TRICORE_TC2/can.c" \
"D:/Project/openblt-master/Target/Source/TRICORE_TC2/cpu.c" \
"D:/Project/openblt-master/Target/Source/TRICORE_TC2/flash.c" \
"D:/Project/openblt-master/Target/Source/TRICORE_TC2/mbrtu.c" \
"D:/Project/openblt-master/Target/Source/TRICORE_TC2/nvm.c" \
"D:/Project/openblt-master/Target/Source/TRICORE_TC2/rs232.c" \
"D:/Project/openblt-master/Target/Source/TRICORE_TC2/timer.c" 

COMPILED_SRCS += \
"Core/TRICORE_TC2/can.src" \
"Core/TRICORE_TC2/cpu.src" \
"Core/TRICORE_TC2/flash.src" \
"Core/TRICORE_TC2/mbrtu.src" \
"Core/TRICORE_TC2/nvm.src" \
"Core/TRICORE_TC2/rs232.src" \
"Core/TRICORE_TC2/timer.src" 

C_DEPS += \
"./Core/TRICORE_TC2/can.d" \
"./Core/TRICORE_TC2/cpu.d" \
"./Core/TRICORE_TC2/flash.d" \
"./Core/TRICORE_TC2/mbrtu.d" \
"./Core/TRICORE_TC2/nvm.d" \
"./Core/TRICORE_TC2/rs232.d" \
"./Core/TRICORE_TC2/timer.d" 

OBJS += \
"Core/TRICORE_TC2/can.o" \
"Core/TRICORE_TC2/cpu.o" \
"Core/TRICORE_TC2/flash.o" \
"Core/TRICORE_TC2/mbrtu.o" \
"Core/TRICORE_TC2/nvm.o" \
"Core/TRICORE_TC2/rs232.o" \
"Core/TRICORE_TC2/timer.o" 


# Each subdirectory must supply rules for building sources it contributes
"Core/TRICORE_TC2/can.src":"D:/Project/openblt-master/Target/Source/TRICORE_TC2/can.c" "Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/TRICORE_TC2/can.o":"Core/TRICORE_TC2/can.src" "Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/TRICORE_TC2/cpu.src":"D:/Project/openblt-master/Target/Source/TRICORE_TC2/cpu.c" "Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/TRICORE_TC2/cpu.o":"Core/TRICORE_TC2/cpu.src" "Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/TRICORE_TC2/flash.src":"D:/Project/openblt-master/Target/Source/TRICORE_TC2/flash.c" "Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/TRICORE_TC2/flash.o":"Core/TRICORE_TC2/flash.src" "Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/TRICORE_TC2/mbrtu.src":"D:/Project/openblt-master/Target/Source/TRICORE_TC2/mbrtu.c" "Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/TRICORE_TC2/mbrtu.o":"Core/TRICORE_TC2/mbrtu.src" "Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/TRICORE_TC2/nvm.src":"D:/Project/openblt-master/Target/Source/TRICORE_TC2/nvm.c" "Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/TRICORE_TC2/nvm.o":"Core/TRICORE_TC2/nvm.src" "Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/TRICORE_TC2/rs232.src":"D:/Project/openblt-master/Target/Source/TRICORE_TC2/rs232.c" "Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/TRICORE_TC2/rs232.o":"Core/TRICORE_TC2/rs232.src" "Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/TRICORE_TC2/timer.src":"D:/Project/openblt-master/Target/Source/TRICORE_TC2/timer.c" "Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/TRICORE_TC2/timer.o":"Core/TRICORE_TC2/timer.src" "Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-Core-2f-TRICORE_TC2

clean-Core-2f-TRICORE_TC2:
	-$(RM) ./Core/TRICORE_TC2/can.d ./Core/TRICORE_TC2/can.o ./Core/TRICORE_TC2/can.src ./Core/TRICORE_TC2/cpu.d ./Core/TRICORE_TC2/cpu.o ./Core/TRICORE_TC2/cpu.src ./Core/TRICORE_TC2/flash.d ./Core/TRICORE_TC2/flash.o ./Core/TRICORE_TC2/flash.src ./Core/TRICORE_TC2/mbrtu.d ./Core/TRICORE_TC2/mbrtu.o ./Core/TRICORE_TC2/mbrtu.src ./Core/TRICORE_TC2/nvm.d ./Core/TRICORE_TC2/nvm.o ./Core/TRICORE_TC2/nvm.src ./Core/TRICORE_TC2/rs232.d ./Core/TRICORE_TC2/rs232.o ./Core/TRICORE_TC2/rs232.src ./Core/TRICORE_TC2/timer.d ./Core/TRICORE_TC2/timer.o ./Core/TRICORE_TC2/timer.src

.PHONY: clean-Core-2f-TRICORE_TC2

