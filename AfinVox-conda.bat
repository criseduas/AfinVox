@echo off
Title AfinVox
setlocal enabledelayedexpansion
pushd %~dp0
set CONDA_ROOT_PREFIX=%UserProfile%\Miniconda3
set INSTALL_ENV_DIR=%cd%\env

:menu
for /f "delims=# tokens=*" %%A in ('findstr /b "#" "%~f0"') do @echo(%%A

echo [1] ejecutar AfinVox (runtime)
echo [2] ejecutar AfinVox (conda)
echo [3] Actualizar dependencias (si se selecciona runtime)
echo.

set /p choice=Select an option: 
set choice=%choice: =%

if "%choice%"=="1" (
    cls
    echo.
    git pull
    echo iniciando AfinVox con runtime...
    runtime\python.exe infer-web.py --pycmd runtime\python.exe --port 7897
    pause
    goto menu
) else if "%choice%"=="2" (
    cls
git pull
for /f "delims=# tokens=*" %%A in ('findstr /b "#" "%~f0"') do @echo(%%A

call "%CONDA_ROOT_PREFIX%\condabin\conda.bat" activate "%INSTALL_ENV_DIR%"
    echo iniciando AfinVox con entorno compatible de Conda...
    python infer-web.py --pycmd python --port 7897 --theme dark
    pause
    cls
    goto menu
) else if "%choice%"=="3" (
    cls
    echo verificando si hay actualizaciones de dependencias para el runtime...
runtime\python.exe runtime\Scripts\pip.exe install -r %~dp0assets\requirements\requirements.txt --use-deprecated=legacy-resolver
cls

    pause
    goto menu
)

popd
endlocal
