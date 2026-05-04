################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"../OpenBLT_Core/asserts.c" \
"../OpenBLT_Core/backdoor.c" \
"../OpenBLT_Core/boot.c" \
"../OpenBLT_Core/com.c" \
"../OpenBLT_Core/cop.c" \
"../OpenBLT_Core/events.c" \
"../OpenBLT_Core/file.c" \
"../OpenBLT_Core/infotable.c" \
"../OpenBLT_Core/mb.c" \
"../OpenBLT_Core/net.c" \
"../OpenBLT_Core/xcp.c" 

COMPILED_SRCS += \
"OpenBLT_Core/asserts.src" \
"OpenBLT_Core/backdoor.src" \
"OpenBLT_Core/boot.src" \
"OpenBLT_Core/com.src" \
"OpenBLT_Core/cop.src" \
"OpenBLT_Core/events.src" \
"OpenBLT_Core/file.src" \
"OpenBLT_Core/infotable.src" \
"OpenBLT_Core/mb.src" \
"OpenBLT_Core/net.src" \
"OpenBLT_Core/xcp.src" 

C_DEPS += \
"./OpenBLT_Core/asserts.d" \
"./OpenBLT_Core/backdoor.d" \
"./OpenBLT_Core/boot.d" \
"./OpenBLT_Core/com.d" \
"./OpenBLT_Core/cop.d" \
"./OpenBLT_Core/events.d" \
"./OpenBLT_Core/file.d" \
"./OpenBLT_Core/infotable.d" \
"./OpenBLT_Core/mb.d" \
"./OpenBLT_Core/net.d" \
"./OpenBLT_Core/xcp.d" 

OBJS += \
"OpenBLT_Core/asserts.o" \
"OpenBLT_Core/backdoor.o" \
"OpenBLT_Core/boot.o" \
"OpenBLT_Core/com.o" \
"OpenBLT_Core/cop.o" \
"OpenBLT_Core/events.o" \
"OpenBLT_Core/file.o" \
"OpenBLT_Core/infotable.o" \
"OpenBLT_Core/mb.o" \
"OpenBLT_Core/net.o" \
"OpenBLT_Core/xcp.o" 


# Each subdirectory must supply rules for building sources it contributes
"OpenBLT_Core/asserts.src":"../OpenBLT_Core/asserts.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/asserts.o":"OpenBLT_Core/asserts.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/backdoor.src":"../OpenBLT_Core/backdoor.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/backdoor.o":"OpenBLT_Core/backdoor.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/boot.src":"../OpenBLT_Core/boot.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/boot.o":"OpenBLT_Core/boot.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/com.src":"../OpenBLT_Core/com.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/com.o":"OpenBLT_Core/com.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/cop.src":"../OpenBLT_Core/cop.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/cop.o":"OpenBLT_Core/cop.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/events.src":"../OpenBLT_Core/events.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/events.o":"OpenBLT_Core/events.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/file.src":"../OpenBLT_Core/file.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/file.o":"OpenBLT_Core/file.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/infotable.src":"../OpenBLT_Core/infotable.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/infotable.o":"OpenBLT_Core/infotable.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/mb.src":"../OpenBLT_Core/mb.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/mb.o":"OpenBLT_Core/mb.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/net.src":"../OpenBLT_Core/net.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/net.o":"OpenBLT_Core/net.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/xcp.src":"../OpenBLT_Core/xcp.c" "OpenBLT_Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/xcp.o":"OpenBLT_Core/xcp.src" "OpenBLT_Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-OpenBLT_Core

clean-OpenBLT_Core:
	-$(RM) ./OpenBLT_Core/asserts.d ./OpenBLT_Core/asserts.o ./OpenBLT_Core/asserts.src ./OpenBLT_Core/backdoor.d ./OpenBLT_Core/backdoor.o ./OpenBLT_Core/backdoor.src ./OpenBLT_Core/boot.d ./OpenBLT_Core/boot.o ./OpenBLT_Core/boot.src ./OpenBLT_Core/com.d ./OpenBLT_Core/com.o ./OpenBLT_Core/com.src ./OpenBLT_Core/cop.d ./OpenBLT_Core/cop.o ./OpenBLT_Core/cop.src ./OpenBLT_Core/events.d ./OpenBLT_Core/events.o ./OpenBLT_Core/events.src ./OpenBLT_Core/file.d ./OpenBLT_Core/file.o ./OpenBLT_Core/file.src ./OpenBLT_Core/infotable.d ./OpenBLT_Core/infotable.o ./OpenBLT_Core/infotable.src ./OpenBLT_Core/mb.d ./OpenBLT_Core/mb.o ./OpenBLT_Core/mb.src ./OpenBLT_Core/net.d ./OpenBLT_Core/net.o ./OpenBLT_Core/net.src ./OpenBLT_Core/xcp.d ./OpenBLT_Core/xcp.o ./OpenBLT_Core/xcp.src

.PHONY: clean-OpenBLT_Core

