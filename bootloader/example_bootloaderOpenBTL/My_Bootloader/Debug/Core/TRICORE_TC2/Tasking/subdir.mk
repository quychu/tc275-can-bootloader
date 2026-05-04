################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"D:/Project/openblt-master/Target/Source/TRICORE_TC2/Tasking/cpu_comp.c" 

COMPILED_SRCS += \
"Core/TRICORE_TC2/Tasking/cpu_comp.src" 

C_DEPS += \
"./Core/TRICORE_TC2/Tasking/cpu_comp.d" 

OBJS += \
"Core/TRICORE_TC2/Tasking/cpu_comp.o" 


# Each subdirectory must supply rules for building sources it contributes
"Core/TRICORE_TC2/Tasking/cpu_comp.src":"D:/Project/openblt-master/Target/Source/TRICORE_TC2/Tasking/cpu_comp.c" "Core/TRICORE_TC2/Tasking/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Project/openblt-master/Target/Demo/TRICORE_TC2_TC275_Lite_Kit_ADS/Boot/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"Core/TRICORE_TC2/Tasking/cpu_comp.o":"Core/TRICORE_TC2/Tasking/cpu_comp.src" "Core/TRICORE_TC2/Tasking/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-Core-2f-TRICORE_TC2-2f-Tasking

clean-Core-2f-TRICORE_TC2-2f-Tasking:
	-$(RM) ./Core/TRICORE_TC2/Tasking/cpu_comp.d ./Core/TRICORE_TC2/Tasking/cpu_comp.o ./Core/TRICORE_TC2/Tasking/cpu_comp.src

.PHONY: clean-Core-2f-TRICORE_TC2-2f-Tasking

