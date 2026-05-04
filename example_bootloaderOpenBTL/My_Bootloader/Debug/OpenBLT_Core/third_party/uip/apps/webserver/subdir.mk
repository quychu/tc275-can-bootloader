################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
"../OpenBLT_Core/third_party/uip/apps/webserver/http-strings.c" \
"../OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.c" \
"../OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.c" \
"../OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.c" \
"../OpenBLT_Core/third_party/uip/apps/webserver/httpd.c" 

COMPILED_SRCS += \
"OpenBLT_Core/third_party/uip/apps/webserver/http-strings.src" \
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.src" \
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.src" \
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.src" \
"OpenBLT_Core/third_party/uip/apps/webserver/httpd.src" 

C_DEPS += \
"./OpenBLT_Core/third_party/uip/apps/webserver/http-strings.d" \
"./OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.d" \
"./OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.d" \
"./OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.d" \
"./OpenBLT_Core/third_party/uip/apps/webserver/httpd.d" 

OBJS += \
"OpenBLT_Core/third_party/uip/apps/webserver/http-strings.o" \
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.o" \
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.o" \
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.o" \
"OpenBLT_Core/third_party/uip/apps/webserver/httpd.o" 


# Each subdirectory must supply rules for building sources it contributes
"OpenBLT_Core/third_party/uip/apps/webserver/http-strings.src":"../OpenBLT_Core/third_party/uip/apps/webserver/http-strings.c" "OpenBLT_Core/third_party/uip/apps/webserver/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/apps/webserver/http-strings.o":"OpenBLT_Core/third_party/uip/apps/webserver/http-strings.src" "OpenBLT_Core/third_party/uip/apps/webserver/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.src":"../OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.c" "OpenBLT_Core/third_party/uip/apps/webserver/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.o":"OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.src" "OpenBLT_Core/third_party/uip/apps/webserver/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.src":"../OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.c" "OpenBLT_Core/third_party/uip/apps/webserver/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.o":"OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.src" "OpenBLT_Core/third_party/uip/apps/webserver/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.src":"../OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.c" "OpenBLT_Core/third_party/uip/apps/webserver/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.o":"OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.src" "OpenBLT_Core/third_party/uip/apps/webserver/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"
"OpenBLT_Core/third_party/uip/apps/webserver/httpd.src":"../OpenBLT_Core/third_party/uip/apps/webserver/httpd.c" "OpenBLT_Core/third_party/uip/apps/webserver/subdir.mk"
	cctc -cs --dep-file="$*.d" --misrac-version=2004 -D__CPU__=tc27xd "-fD:/Aurix_Tool/Target_TC275/My_Bootloader/Debug/TASKING_C_C___Compiler-Include_paths__-I_.opt" --iso=99 --c++14 --language=+volatile --exceptions --anachronisms --fp-model=3 -O1 --tradeoff=2 --compact-max-size=200 -g -Wc-w544 -Wc-w557 -Ctc27xd -Y0 -N0 -Z0 -o "$@" "$<"
"OpenBLT_Core/third_party/uip/apps/webserver/httpd.o":"OpenBLT_Core/third_party/uip/apps/webserver/httpd.src" "OpenBLT_Core/third_party/uip/apps/webserver/subdir.mk"
	astc -Og -Os --no-warnings= --error-limit=42 -o  "$@" "$<"

clean: clean-OpenBLT_Core-2f-third_party-2f-uip-2f-apps-2f-webserver

clean-OpenBLT_Core-2f-third_party-2f-uip-2f-apps-2f-webserver:
	-$(RM) ./OpenBLT_Core/third_party/uip/apps/webserver/http-strings.d ./OpenBLT_Core/third_party/uip/apps/webserver/http-strings.o ./OpenBLT_Core/third_party/uip/apps/webserver/http-strings.src ./OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.d ./OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.o ./OpenBLT_Core/third_party/uip/apps/webserver/httpd-cgi.src ./OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.d ./OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.o ./OpenBLT_Core/third_party/uip/apps/webserver/httpd-fs.src ./OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.d ./OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.o ./OpenBLT_Core/third_party/uip/apps/webserver/httpd-fsdata.src ./OpenBLT_Core/third_party/uip/apps/webserver/httpd.d ./OpenBLT_Core/third_party/uip/apps/webserver/httpd.o ./OpenBLT_Core/third_party/uip/apps/webserver/httpd.src

.PHONY: clean-OpenBLT_Core-2f-third_party-2f-uip-2f-apps-2f-webserver

