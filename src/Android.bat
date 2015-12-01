set adt="D:\Sepehr\SoftWares\air19\bin\adt.bat"

rem this is for debugging V
set adl="D:\Sepehr\SoftWares\air19\bin\adl.exe"

set name=Ofogh


set contents= Data AppIconsForPublish
rem "AppIconsForPublish"
set ios_contents=Default.png Default@2x.png Default-568h@2x.png Default-568h-Portrait@2x.png Default-Landscape.png Default-Landscape@2x~ipad.png Default-Landscape~ipad.png Default-Portrait.png Default-Portrait@2x~ipad.png Default-Portrait~ipad.png
set ios_certificate=D:\Sepehr\MTeam Certifications\MTeam IOS Certificate_dev.p12
rem D:\Sepehr\MTeam Certifications\93-07-10\Certificates_dev.p12
rem D:\Sepehr\MTeam Certifications\MTeam IOS Certificate.p12
set ios_pass=NewPass123$
set ios_mobprevision=D:\Sepehr\MTeam Certifications\test.mobileprovision
set ios_targ=ipa-ad-hoc
set ios_useLegacy=
rem -useLegacyAOT yes   -useLegacyAOT no
rem ipa-ad-hoc    ipa-app-store   ipa-debug -connect 192.168.0.15
rem    ipa-ad-hoc — an iOS package for ad hoc distribution.

rem    ipa-app-store — an iOS package for Apple App store distribution.

rem    ipa-debug — an iOS package with extra debugging information. (The SWF files in the application must also be compiled with debugging support.)

rem    ipa-test — an iOS package compiled without optimization or debugging information.

rem    ipa-debug-interpreter — functionally equivalent to a debug package, but compiles more quickly. However, the ActionScript bytecode is interpreted and not translated to machine code. As a result, code execution is slower in an interpreter package.

rem    ipa-debug-interpreter-simulator — functionally equivalent to ipa-debug-interpreter, but packaged for the iOS simulator. Macintosh-only. If you use this option, you must also include the -platformsdk option, specifying the path to the iOS Simulator SDK.

rem    ipa-test-interpreter — functionally equivalent to a test package, but compiles more quickly. However, the ActionScript bytecode is interpreted and not translated to machine code. As a result, code execution is slower in an interpreter package.

rem    ipa-test-interpreter-simulator — functionally equivalent to ipa-test-interpreter, but packaged for the iOS simulator. Macintosh-only. If you use this option, you must also include the -platformsdk option, specifying the path to the iOS Simulator SDK.


set android_certificate=D:\Sepehr\MTeam Certifications\MTeam Certification File.p12
set android_pass=NewPass123$
set android_target=apk-captive-runtime
rem :apk-debug -connect 192.168.0.15         apk-captive-runtime
rem :apk — an Android package. A package produced with this target can only be installed on an Android device, not an emulator.
rem :apk?captive?runtime — an Android package that includes both the application and a captive version of the AIR runtime. A package produced with this target can only be installed on an Android device, not an emulator.
rem :apk-debug — an Android package with extra debugging information. (The SWF files in the application must also be compiled with debugging support.)
rem :apk-emulator — an Android package for use on an emulator without debugging support. (Use the apk-debug target to permit debugging on both emulators and devices.)
rem :apk-profile — an Android package that supports application performance and memory profiling.

set native_folder=
rem -extdir "natives"








set dAA3=1024x768:1024x768
rem debugger V
rem %adl% -profile mobileDevice -screensize %dAA3% "%name%-app.xml"



rem 

rem android export V
%adt% -package -target %android_target%  -storetype pkcs12 -storepass %android_pass% -keystore "%android_certificate%" "%name%.apk" "%name%-app.xml" "%name%.swf" %contents% %native_folder%


rem IOS export V
rem %adt% -package -target %ios_targ% %ios_useLegacy% -keystore "%ios_certificate%" -storetype pkcs12 -storepass %ios_pass%  -provisioning-profile  "%ios_mobprevision%"  "%name%.ipa" "%name%-app.xml"  "%name%.swf"  %contents% %ios_contents% %native_folder%