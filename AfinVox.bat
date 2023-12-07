@echo off
Title AfinVox
setlocal enabledelayedexpansion
pushd %~dp0

:menu
for /f "delims=# tokens=*" %%A in ('findstr /b "#" "%~f0"') do @echo(%%A

echo [1] ejecutar AfinVox
echo [2] Actualizar dependencias
echo.

choice /c:12 /m "Seleccione una opcion:"

if %errorlevel%==1 (
    echo.
    git pull
    if errorlevel 1 (
        echo No se pudo actualizar el repositorio de GitHub.
        echo Comprueba tu conexion a internet y que GitHub está instalado en el equipo.
        exit /b 2
    )

    runtime\python.exe infer-web.py --pycmd runtime\python.exe --port 7897
    pause
    goto menu
)

if %errorlevel%==2 (
    echo.
    if not exist %~dp0assets\requirements\requirements.txt (
        echo El archivo %~dp0assets\requirements\requirements.txt no existe.
        echo ejecuta el archivo instalar_AfinVox.bat
        exit /b 5
    )
runtime\python.exe runtime\Scripts\pip.exe install -r %~dp0assets\requirements\requirements.txt --use-deprecated=legacy-resolver
cls

    pause
    goto menu
)

popd
endlocal
