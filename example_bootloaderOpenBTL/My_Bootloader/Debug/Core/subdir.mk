################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"D:/Project/openblt-master/Target/Source/asserts.c" \
"D:/Project/openblt-master/Target/Source/backdoor.c" \
"D:/Project/openblt-master/Target/Source/boot.c" \
"D:/Project/openblt-master/Target/Source/com.c" \
"D:/Project/openblt-master/Target/Source/cop.c" \
"D:/Project/openblt-master/Target/Source/events.c" \
"D:/Project/openblt-master/Target/Source/file.c" \
"D:/Project/openblt-master/Target/Source/infotable.c" \
"D:/Project/openblt-master/Target/Source/mb.c" \
"D:/Project/openblt-master/Target/Source/net.c" \
"D:/Project/openblt-master/Target/Source/xcp.c" 

COMPILED_SRCS += \
"Core/asserts.src" \
"Core/backdoor.src" \
"Core/boot.src" \
"Core/com.src" \
"Core/cop.src" \
"Core/events.src" \
"Core/file.src" \
"Core/infotable.src" \
"Core/mb.src" \
"Core/net.src" \
"Core/xcp.src" 

C_DEPS += \
"./Core/asserts.d" \
"./Core/backdoor.d" \
"./Core/boot.d" \
"./Core/com.d" \
"./Core/cop.d" \
"./Core/events.d" \
"./Core/file.d" \
"./Core/infotable.d" \
"./Core/mb.d" \
"./Core/net.d" \
"./Core/xcp.d" 

OBJS += \
"Core/asserts.o" \
"Core/backdoor.o" \
"Core/boot.o" \
"Core/com.o" \
"Core/cop.o" \
"Core/events.o" \
"Core/file.o" \
"Core/infotable.o" \
"Core/mb.o" \
"Core/net.o" \
"Core/xcp.o" 


# Each subdirectory must supply rules for building sources it contributes
"Core/asserts.src":"D:/Project/openblt-master/Target/Source/asserts.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/asserts.o":"Core/asserts.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/backdoor.src":"D:/Project/openblt-master/Target/Source/backdoor.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/backdoor.o":"Core/backdoor.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/boot.src":"D:/Project/openblt-master/Target/Source/boot.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/boot.o":"Core/boot.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/com.src":"D:/Project/openblt-master/Target/Source/com.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/com.o":"Core/com.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/cop.src":"D:/Project/openblt-master/Target/Source/cop.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/cop.o":"Core/cop.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/events.src":"D:/Project/openblt-master/Target/Source/events.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/events.o":"Core/events.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/file.src":"D:/Project/openblt-master/Target/Source/file.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/file.o":"Core/file.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/infotable.src":"D:/Project/openblt-master/Target/Source/infotable.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/infotable.o":"Core/infotable.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/mb.src":"D:/Project/openblt-master/Target/Source/mb.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/mb.o":"Core/mb.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/net.src":"D:/Project/openblt-master/Target/Source/net.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/net.o":"Core/net.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"Core/xcp.src":"D:/Project/openblt-master/Target/Source/xcp.c" "Core/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/xcp.o":"Core/xcp.src" "Core/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-Core

clean-Core:
	-$(RM) ./Core/asserts.d ./Core/asserts.o ./Core/asserts.src ./Core/backdoor.d ./Core/backdoor.o ./Core/backdoor.src ./Core/boot.d ./Core/boot.o ./Core/boot.src ./Core/com.d ./Core/com.o ./Core/com.src ./Core/cop.d ./Core/cop.o ./Core/cop.src ./Core/events.d ./Core/events.o ./Core/events.src ./Core/file.d ./Core/file.o ./Core/file.src ./Core/infotable.d ./Core/infotable.o ./Core/infotable.src ./Core/mb.d ./Core/mb.o ./Core/mb.src ./Core/net.d ./Core/net.o ./Core/net.src ./Core/xcp.d ./Core/xcp.o ./Core/xcp.src

.PHONY: clean-Core

