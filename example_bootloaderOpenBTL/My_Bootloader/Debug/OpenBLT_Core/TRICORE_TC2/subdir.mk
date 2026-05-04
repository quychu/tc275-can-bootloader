################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"../OpenBLT_Core/TRICORE_TC2/can.c" \
"../OpenBLT_Core/TRICORE_TC2/cpu.c" \
"../OpenBLT_Core/TRICORE_TC2/flash.c" \
"../OpenBLT_Core/TRICORE_TC2/mbrtu.c" \
"../OpenBLT_Core/TRICORE_TC2/nvm.c" \
"../OpenBLT_Core/TRICORE_TC2/rs232.c" \
"../OpenBLT_Core/TRICORE_TC2/timer.c" 

COMPILED_SRCS += \
"OpenBLT_Core/TRICORE_TC2/can.src" \
"OpenBLT_Core/TRICORE_TC2/cpu.src" \
"OpenBLT_Core/TRICORE_TC2/flash.src" \
"OpenBLT_Core/TRICORE_TC2/mbrtu.src" \
"OpenBLT_Core/TRICORE_TC2/nvm.src" \
"OpenBLT_Core/TRICORE_TC2/rs232.src" \
"OpenBLT_Core/TRICORE_TC2/timer.src" 

C_DEPS += \
"./OpenBLT_Core/TRICORE_TC2/can.d" \
"./OpenBLT_Core/TRICORE_TC2/cpu.d" \
"./OpenBLT_Core/TRICORE_TC2/flash.d" \
"./OpenBLT_Core/TRICORE_TC2/mbrtu.d" \
"./OpenBLT_Core/TRICORE_TC2/nvm.d" \
"./OpenBLT_Core/TRICORE_TC2/rs232.d" \
"./OpenBLT_Core/TRICORE_TC2/timer.d" 

OBJS += \
"OpenBLT_Core/TRICORE_TC2/can.o" \
"OpenBLT_Core/TRICORE_TC2/cpu.o" \
"OpenBLT_Core/TRICORE_TC2/flash.o" \
"OpenBLT_Core/TRICORE_TC2/mbrtu.o" \
"OpenBLT_Core/TRICORE_TC2/nvm.o" \
"OpenBLT_Core/TRICORE_TC2/rs232.o" \
"OpenBLT_Core/TRICORE_TC2/timer.o" 


# Each subdirectory must supply rules for building sources it contributes
"OpenBLT_Core/TRICORE_TC2/can.src":"../OpenBLT_Core/TRICORE_TC2/can.c" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/can.o":"OpenBLT_Core/TRICORE_TC2/can.src" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/cpu.src":"../OpenBLT_Core/TRICORE_TC2/cpu.c" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/cpu.o":"OpenBLT_Core/TRICORE_TC2/cpu.src" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/flash.src":"../OpenBLT_Core/TRICORE_TC2/flash.c" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/flash.o":"OpenBLT_Core/TRICORE_TC2/flash.src" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/mbrtu.src":"../OpenBLT_Core/TRICORE_TC2/mbrtu.c" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/mbrtu.o":"OpenBLT_Core/TRICORE_TC2/mbrtu.src" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/nvm.src":"../OpenBLT_Core/TRICORE_TC2/nvm.c" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/nvm.o":"OpenBLT_Core/TRICORE_TC2/nvm.src" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/rs232.src":"../OpenBLT_Core/TRICORE_TC2/rs232.c" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/rs232.o":"OpenBLT_Core/TRICORE_TC2/rs232.src" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/timer.src":"../OpenBLT_Core/TRICORE_TC2/timer.c" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/TRICORE_TC2/timer.o":"OpenBLT_Core/TRICORE_TC2/timer.src" "OpenBLT_Core/TRICORE_TC2/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-OpenBLT_Core-2f-TRICORE_TC2

clean-OpenBLT_Core-2f-TRICORE_TC2:
	-$(RM) ./OpenBLT_Core/TRICORE_TC2/can.d ./OpenBLT_Core/TRICORE_TC2/can.o ./OpenBLT_Core/TRICORE_TC2/can.src ./OpenBLT_Core/TRICORE_TC2/cpu.d ./OpenBLT_Core/TRICORE_TC2/cpu.o ./OpenBLT_Core/TRICORE_TC2/cpu.src ./OpenBLT_Core/TRICORE_TC2/flash.d ./OpenBLT_Core/TRICORE_TC2/flash.o ./OpenBLT_Core/TRICORE_TC2/flash.src ./OpenBLT_Core/TRICORE_TC2/mbrtu.d ./OpenBLT_Core/TRICORE_TC2/mbrtu.o ./OpenBLT_Core/TRICORE_TC2/mbrtu.src ./OpenBLT_Core/TRICORE_TC2/nvm.d ./OpenBLT_Core/TRICORE_TC2/nvm.o ./OpenBLT_Core/TRICORE_TC2/nvm.src ./OpenBLT_Core/TRICORE_TC2/rs232.d ./OpenBLT_Core/TRICORE_TC2/rs232.o ./OpenBLT_Core/TRICORE_TC2/rs232.src ./OpenBLT_Core/TRICORE_TC2/timer.d ./OpenBLT_Core/TRICORE_TC2/timer.o ./OpenBLT_Core/TRICORE_TC2/timer.src

.PHONY: clean-OpenBLT_Core-2f-TRICORE_TC2

