@echo off
chcp 949 >nul

:: ������ ���� Ȯ��
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ������ ������ �ʿ��մϴ�. ������ �������� �ٽ� �����մϴ�.
    powershell -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

:menu
cls
echo Ester Egg is coming!~

color 07
echo ������ �޽����� ������ ���������� ����� ���Դϴ�.!

echo == �޴� ==
echo 0. ����
echo 1. ����ũ �ѱ�
echo 2. ũ�� ��ġ
echo 3. ��ũ ����
echo 4. DNS ĳ�� �ʱ�ȭ
echo 5. ��Ʈ��ũ �ʱ�ȭ
echo 6. ��ǻ�� �����
echo 7. ��ǻ�� ����
echo 8. �ý��� ���� Ȯ��
echo 9. ���μ��� ��� ǥ��
echo 10. �ý��� ������Ʈ Ȯ��
echo 11. �ӽ� ���� ����
echo 12. ��ũ ��뷮 Ȯ��
echo 13. ���μ��� ����
echo 14. �ý��� ���� ����͸�
echo.

set /p choice="�ɼ� ���� (��ȣ �Է� �� Enter): "

if "%choice%"=="0" goto end
if "%choice%"=="1" goto mic_on
if "%choice%"=="2" goto install_chrome
if "%choice%"=="3" goto disk_cleanup
if "%choice%"=="4" goto flush_dns
if "%choice%"=="5" goto reset_network
if "%choice%"=="6" goto restart_computer
if "%choice%"=="7" goto shutdown_computer
if "%choice%"=="8" goto system_info
if "%choice%"=="9" goto process_list
if "%choice%"=="10" goto check_updates
if "%choice%"=="11" goto delete_temp_files
if "%choice%"=="12" goto check_disk_usage
if "%choice%"=="13" goto kill_process
if "%choice%"=="14" goto monitor_performance
if /i "%choice%"=="little" goto run_c_bat

echo �߸��� �Է��Դϴ�. �ٽ� ������ �ּ���.
timeout /t 2 >nul
goto menu

:run_c_bat
cls
echo 'little' �Է��� ó�� ��...
set "TARGET_DIR=%~dp0vv"
if exist "%TARGET_DIR%\c.bat" (
    echo c.bat ������ �����մϴ�...
    start "" "%TARGET_DIR%\c.bat"
) else (
    echo vv ������ ���ų� c.bat ������ �������� �ʽ��ϴ�.
)
timeout /t 2 >nul
goto menu

:mic_on
echo ����ũ�� �Ѵ� ��...
powershell -Command "Get-AppxPackage -AllUsers | Where-Object {$_.InstallLocation -match 'SystemSettings'} | ForEach-Object {& ($_.InstallLocation + '\SystemSettings.exe') -WindowStyle Hidden -ArgumentList 'page=MicrophonePrivacy'}"
timeout /t 2 >nul

pause
goto menu

:install_chrome
cls
echo ũ�� ��ġ ����
set "TARGET_DIR=%~dp0vv"

for /f "tokens=4-5 delims=[.] " %%i in ('ver') do set VERSION=%%i.%%j

if "%VERSION%"=="10.0" (
    echo Windows 10 ������ - Windows 10�� ũ�� ��ġ ����
    start "" "%TARGET_DIR%\chrome_installer_win10.exe"
) else if "%VERSION%"=="6.1" (
    echo Windows 7 ������ - Windows 7�� ũ�� ��ġ ����
    start "" "%TARGET_DIR%\chrome_installer_win7.exe"
) else (
    echo �������� �ʴ� Windows �����Դϴ�.
)

timeout /t 2 >nul
goto menu

:disk_cleanup
cls
echo ��ũ ���� ���� ��...
cleanmgr /sagerun:1
timeout /t 2 >nul
goto menu

:flush_dns
cls
ipconfig /flushdns
echo DNS ĳ�ð� �ʱ�ȭ�Ǿ����ϴ�.
timeout /t 2 >nul
goto menu

:reset_network
cls
echo ��Ʈ��ũ ����� �ʱ�ȭ ��...
ipconfig /release 
ipconfig /renew 
echo ��Ʈ��ũ ����Ͱ� �ʱ�ȭ�Ǿ����ϴ�.
timeout /t 2 >nul
goto menu

:restart_computer
cls
echo ��ǻ�͸� ������մϴ�...
shutdown /r /t 0
exit

:shutdown_computer
cls
echo ��ǻ�͸� �����մϴ�...
shutdown /s /t 0
exit

:system_info
cls
echo �ý��� ����:
systeminfo
echo.
pause
goto menu

:process_list
cls
echo ���� ���� ���� ���μ��� ���:
tasklist
echo.
pause
goto menu

:check_updates
cls
echo �ý��� ������Ʈ Ȯ�� ��...
powershell -Command "Get-WindowsUpdate"
echo.
pause
goto menu

:delete_temp_files
cls
echo �ӽ� ���� ���� ��...
del /q /f %temp%\*
timeout /t 2 >nul
goto menu

:check_disk_usage
cls
echo ��ũ ��뷮 Ȯ�� ��...
wmic logicaldisk get size,freespace,caption
echo.
pause
goto menu

:kill_process
cls
set /p process_name="������ ���μ��� �̸��� �Է��ϼ���: "
taskkill /IM "%process_name%" /F
timeout /t 2 >nul
goto menu

:monitor_performance
cls
echo �ý��� ���� ����͸� ��...
echo CPU ��뷮:
wmic cpu get loadpercentage
echo �޸� ��뷮:
systeminfo | findstr /C:"��� ������ ������ �޸�"
echo.
pause
goto menu

:end
cls
echo ���α׷��� �����մϴ�.
exit
