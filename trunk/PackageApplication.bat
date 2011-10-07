@echo off
set FLEX_SDK=D:\Flex4.5SDK
set dt=%date%
set fpfx=%dt:~-10,4%%dt:~-5,2%%dt:~-2,2%


:: AIR application packaging
:: More information:
:: http://livedocs.adobe.com/flex/3/html/help.html?content=CommandLineTools_5.html#1035959

:: Path to Flex SDK binaries
set PATH=%PATH%;%FLEX_SDK%\bin

:: Signature (see 'CreateCertificate.bat')
set CERTIFICATE="iBBDemo3.pfx"
set SIGNING_OPTIONS=-storetype pkcs12 -keystore %CERTIFICATE% -tsa none 
if not exist %CERTIFICATE% goto certificate

:: Output
if not exist air md air
set AIR_FILE=air/iBBDemo3-%fpfx%.air

:: Input
set APP_XML=src\ShaunAirFlex-app.xml 
set FILE_OR_DIR=-C bin .

echo Signing AIR setup using certificate %CERTIFICATE%.
call adt -package %SIGNING_OPTIONS% %AIR_FILE% %APP_XML% %FILE_OR_DIR%
if errorlevel 1 goto failed

echo.
echo AIR setup created: %AIR_FILE%
echo.
goto end

:certificate
echo Certificate not found: %CERTIFICATE%
echo.
echo Troubleshotting: 
echo A certificate is required, generate one using 'CreateCertificate.bat'
echo.
goto end

:failed
echo AIR setup creation FAILED.
echo.
echo Troubleshotting: 
echo did you configure the Flex SDK path in this Batch file?
echo.

:end
pause
