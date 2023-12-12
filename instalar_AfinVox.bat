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
set "fixesFolder=lib/fixes"
set "localFixesPy=local_fixes.py"

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
del instalar_AfinVox.bat
del /q *.sh
echo.
cls

echo instalando dependencias...
echo.
echo (no compatible con GPUs de intel y AMD): 
cls
curl -LJO "%URL_EXTRA%/runtime.zip"
echo.
echo Extracting the runtime.zip file...
powershell -command "& { Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory('runtime.zip', '%principal%') }"
echo.
del runtime.zip
runtime\python.exe runtime\Scripts\pip.exe install --upgrade setuptools
runtime\python.exe runtime\Scripts\pip.exe install wget bs4 flask_cors flask torchvision==0.15.1 --index-url https://download.pytorch.org/whl/cu118
runtime\python.exe runtime\Scripts\pip.exe install -r %principal%\assets\requirements\requirements.txt --use-deprecated=legacy-resolver
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

