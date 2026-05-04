################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"../OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.c" \
"../OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.c" \
"../OpenBLT_Core/third_party/uip/doc/uip-code-style.c" 

COMPILED_SRCS += \
"OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.src" \
"OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.src" \
"OpenBLT_Core/third_party/uip/doc/uip-code-style.src" 

C_DEPS += \
"./OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.d" \
"./OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.d" \
"./OpenBLT_Core/third_party/uip/doc/uip-code-style.d" 

OBJS += \
"OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.o" \
"OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.o" \
"OpenBLT_Core/third_party/uip/doc/uip-code-style.o" 


# Each subdirectory must supply rules for building sources it contributes
"OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.src":"../OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.c" "OpenBLT_Core/third_party/uip/doc/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.o":"OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.src" "OpenBLT_Core/third_party/uip/doc/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.src":"../OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.c" "OpenBLT_Core/third_party/uip/doc/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.o":"OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.src" "OpenBLT_Core/third_party/uip/doc/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/doc/uip-code-style.src":"../OpenBLT_Core/third_party/uip/doc/uip-code-style.c" "OpenBLT_Core/third_party/uip/doc/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/doc/uip-code-style.o":"OpenBLT_Core/third_party/uip/doc/uip-code-style.src" "OpenBLT_Core/third_party/uip/doc/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-OpenBLT_Core-2f-third_party-2f-uip-2f-doc

clean-OpenBLT_Core-2f-third_party-2f-uip-2f-doc:
	-$(RM) ./OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.d ./OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.o ./OpenBLT_Core/third_party/uip/doc/example-mainloop-with-arp.src ./OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.d ./OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.o ./OpenBLT_Core/third_party/uip/doc/example-mainloop-without-arp.src ./OpenBLT_Core/third_party/uip/doc/uip-code-style.d ./OpenBLT_Core/third_party/uip/doc/uip-code-style.o ./OpenBLT_Core/third_party/uip/doc/uip-code-style.src

.PHONY: clean-OpenBLT_Core-2f-third_party-2f-uip-2f-doc

