################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"../OpenBLT_Core/third_party/uip/uip/psock.c" \
"../OpenBLT_Core/third_party/uip/uip/uip-fw.c" \
"../OpenBLT_Core/third_party/uip/uip/uip-neighbor.c" \
"../OpenBLT_Core/third_party/uip/uip/uip-split.c" \
"../OpenBLT_Core/third_party/uip/uip/uip.c" \
"../OpenBLT_Core/third_party/uip/uip/uip_arp.c" \
"../OpenBLT_Core/third_party/uip/uip/uip_timer.c" \
"../OpenBLT_Core/third_party/uip/uip/uiplib.c" 

COMPILED_SRCS += \
"OpenBLT_Core/third_party/uip/uip/psock.src" \
"OpenBLT_Core/third_party/uip/uip/uip-fw.src" \
"OpenBLT_Core/third_party/uip/uip/uip-neighbor.src" \
"OpenBLT_Core/third_party/uip/uip/uip-split.src" \
"OpenBLT_Core/third_party/uip/uip/uip.src" \
"OpenBLT_Core/third_party/uip/uip/uip_arp.src" \
"OpenBLT_Core/third_party/uip/uip/uip_timer.src" \
"OpenBLT_Core/third_party/uip/uip/uiplib.src" 

C_DEPS += \
"./OpenBLT_Core/third_party/uip/uip/psock.d" \
"./OpenBLT_Core/third_party/uip/uip/uip-fw.d" \
"./OpenBLT_Core/third_party/uip/uip/uip-neighbor.d" \
"./OpenBLT_Core/third_party/uip/uip/uip-split.d" \
"./OpenBLT_Core/third_party/uip/uip/uip.d" \
"./OpenBLT_Core/third_party/uip/uip/uip_arp.d" \
"./OpenBLT_Core/third_party/uip/uip/uip_timer.d" \
"./OpenBLT_Core/third_party/uip/uip/uiplib.d" 

OBJS += \
"OpenBLT_Core/third_party/uip/uip/psock.o" \
"OpenBLT_Core/third_party/uip/uip/uip-fw.o" \
"OpenBLT_Core/third_party/uip/uip/uip-neighbor.o" \
"OpenBLT_Core/third_party/uip/uip/uip-split.o" \
"OpenBLT_Core/third_party/uip/uip/uip.o" \
"OpenBLT_Core/third_party/uip/uip/uip_arp.o" \
"OpenBLT_Core/third_party/uip/uip/uip_timer.o" \
"OpenBLT_Core/third_party/uip/uip/uiplib.o" 


# Each subdirectory must supply rules for building sources it contributes
"OpenBLT_Core/third_party/uip/uip/psock.src":"../OpenBLT_Core/third_party/uip/uip/psock.c" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/psock.o":"OpenBLT_Core/third_party/uip/uip/psock.src" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip-fw.src":"../OpenBLT_Core/third_party/uip/uip/uip-fw.c" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip-fw.o":"OpenBLT_Core/third_party/uip/uip/uip-fw.src" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip-neighbor.src":"../OpenBLT_Core/third_party/uip/uip/uip-neighbor.c" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip-neighbor.o":"OpenBLT_Core/third_party/uip/uip/uip-neighbor.src" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip-split.src":"../OpenBLT_Core/third_party/uip/uip/uip-split.c" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip-split.o":"OpenBLT_Core/third_party/uip/uip/uip-split.src" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip.src":"../OpenBLT_Core/third_party/uip/uip/uip.c" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip.o":"OpenBLT_Core/third_party/uip/uip/uip.src" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip_arp.src":"../OpenBLT_Core/third_party/uip/uip/uip_arp.c" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip_arp.o":"OpenBLT_Core/third_party/uip/uip/uip_arp.src" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip_timer.src":"../OpenBLT_Core/third_party/uip/uip/uip_timer.c" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uip_timer.o":"OpenBLT_Core/third_party/uip/uip/uip_timer.src" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uiplib.src":"../OpenBLT_Core/third_party/uip/uip/uiplib.c" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/uip/uiplib.o":"OpenBLT_Core/third_party/uip/uip/uiplib.src" "OpenBLT_Core/third_party/uip/uip/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-OpenBLT_Core-2f-third_party-2f-uip-2f-uip

clean-OpenBLT_Core-2f-third_party-2f-uip-2f-uip:
	-$(RM) ./OpenBLT_Core/third_party/uip/uip/psock.d ./OpenBLT_Core/third_party/uip/uip/psock.o ./OpenBLT_Core/third_party/uip/uip/psock.src ./OpenBLT_Core/third_party/uip/uip/uip-fw.d ./OpenBLT_Core/third_party/uip/uip/uip-fw.o ./OpenBLT_Core/third_party/uip/uip/uip-fw.src ./OpenBLT_Core/third_party/uip/uip/uip-neighbor.d ./OpenBLT_Core/third_party/uip/uip/uip-neighbor.o ./OpenBLT_Core/third_party/uip/uip/uip-neighbor.src ./OpenBLT_Core/third_party/uip/uip/uip-split.d ./OpenBLT_Core/third_party/uip/uip/uip-split.o ./OpenBLT_Core/third_party/uip/uip/uip-split.src ./OpenBLT_Core/third_party/uip/uip/uip.d ./OpenBLT_Core/third_party/uip/uip/uip.o ./OpenBLT_Core/third_party/uip/uip/uip.src ./OpenBLT_Core/third_party/uip/uip/uip_arp.d ./OpenBLT_Core/third_party/uip/uip/uip_arp.o ./OpenBLT_Core/third_party/uip/uip/uip_arp.src ./OpenBLT_Core/third_party/uip/uip/uip_timer.d ./OpenBLT_Core/third_party/uip/uip/uip_timer.o ./OpenBLT_Core/third_party/uip/uip/uip_timer.src ./OpenBLT_Core/third_party/uip/uip/uiplib.d ./OpenBLT_Core/third_party/uip/uip/uiplib.o ./OpenBLT_Core/third_party/uip/uip/uiplib.src

.PHONY: clean-OpenBLT_Core-2f-third_party-2f-uip-2f-uip

