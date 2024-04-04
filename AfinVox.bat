@echo off
Title AfinVox
setlocal enabledelayedexpansion
pushd %~dp0
set CONDA_ROOT_PREFIX=%cd%\env
set INSTALL_ENV_DIR=%cd%\env
call "%CONDA_ROOT_PREFIX%\condabin\conda.bat" activate "%INSTALL_ENV_DIR%"
python infer-web.py --pycmd python --port 7897 --theme dark

popd
endlocal
