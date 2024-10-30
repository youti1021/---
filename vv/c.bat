@echo off
setlocal
echo Installer v.1
echo Made by. 승준

echo Downloading Python installer...
powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.5/python-3.12.5-amd64.exe' -OutFile 'python-installer.exe'"

echo Installing Python...
python-installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

echo Cleaning up...
del python-installer.exe

echo Python installation is complete.

set "REPO_URL=https://github.com/youti1021/LAEC/archive/refs/heads/main.zip"
set "OUTPUT_ZIP=LAEC-main.zip"
set "EXTRACT_DIR=LAEC-main"

set "SELF_DELETE_CMD=del /q /f %~f0"

echo Downloading LAEC repository...
powershell -Command "Invoke-WebRequest -Uri %REPO_URL% -OutFile %OUTPUT_ZIP%"

echo Extracting the ZIP file...
powershell -Command "Expand-Archive -Path %OUTPUT_ZIP% -DestinationPath . -Force"

cd %EXTRACT_DIR%

echo Installing required Python packages...
python -m pip install pillow pyscreeze pyautogui numpy opencv-python

echo Running index.py...
python -m index.py

endlocal