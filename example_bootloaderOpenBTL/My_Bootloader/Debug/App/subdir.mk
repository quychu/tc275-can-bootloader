################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"../App/app.c" \
"../App/hooks.c" \
"../App/led.c" 

COMPILED_SRCS += \
"App/app.src" \
"App/hooks.src" \
"App/led.src" 

C_DEPS += \
"./App/app.d" \
"./App/hooks.d" \
"./App/led.d" 

OBJS += \
"App/app.o" \
"App/hooks.o" \
"App/led.o" 


# Each subdirectory must supply rules for building sources it contributes
"App/app.src":"../App/app.c" "App/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"App/app.o":"App/app.src" "App/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"App/hooks.src":"../App/hooks.c" "App/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"App/hooks.o":"App/hooks.src" "App/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"App/led.src":"../App/led.c" "App/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"App/led.o":"App/led.src" "App/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-App

clean-App:
	-$(RM) ./App/app.d ./App/app.o ./App/app.src ./App/hooks.d ./App/hooks.o ./App/hooks.src ./App/led.d ./App/led.o ./App/led.src

.PHONY: clean-App

