@echo off
Title AfinVox
setlocal
cd %~dp0

:::
:::                       _ _

set "repoUrl=https://github.com/criseduas/AfinVox.git"
set "repoFolder=AfinVox"
set "principal=%cd%\%repoFolder%"
set "runtime_scripts=%cd%\%repoFolder%\runtime\Scripts"
set "URL_BASE=https://huggingface.co/lj1995/VoiceConversionWebUI/resolve/main"
set "URL_EXTRA=https://huggingface.co/IAHispano/applio/resolve/main"

echo.
cls
echo INFO: Por favor, no ejecute este archivo como administrador, ya que puede causar problemas. Si experimenta errores a la hora de descargar los archivos de preentrenamiento, desactive temporalmente el antivirus y el firewall.
echo.
pause

cls
for /f "delims=: tokens=*" %%A in ('findstr /b ":::" "%~f0"') do @echo(%%A
echo.

echo clonando el repositorio...
git clone %repoUrl% %repoFolder%
cd %repoFolder%
del install_Applio.bat
del /q *.sh
echo.
cls

echo instalando dependencias...
echo.
echo (no compatible con GPUs de intel y AMD): 
cls
powershell -command "Invoke-WebRequest -Uri https://huggingface.co/IAHispano/applio/resolve/main/busybox.exe -OutFile busybox.exe"
busybox.exe wget %URL_EXTRA%/runtime.zip
echo.
echo Extracting the runtime.zip file...
powershell -command "& { Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory('runtime.zip', '%principal%') }"
echo.
del runtime.zip busybox.exe
cls
echo.
goto dependenciesFinished
)

:dependenciesFinished
cls 
echo AfinVox ha sido instalado correctamente, ejecute el archivo AfinVox.bat para iniciar la interfaz web!
echo.
pause
exit

