@echo off
chcp 949 >nul

:: 관리자 권한 확인
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo 관리자 권한이 필요합니다. 관리자 권한으로 다시 실행합니다.
    powershell -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

:menu
cls
echo Ester Egg is coming!~

color 07
echo 붉은색 메시지가 없으면 성공적으로 실행된 것입니다.!

echo == 메뉴 ==
echo 0. 종료
echo 1. 마이크 켜기
echo 2. 크롬 설치
echo 3. 디스크 정리
echo 4. DNS 캐시 초기화
echo 5. 네트워크 초기화
echo 6. 컴퓨터 재시작
echo 7. 컴퓨터 종료
echo 8. 시스템 정보 확인
echo 9. 프로세스 목록 표시
echo 10. 시스템 업데이트 확인
echo 11. 임시 파일 삭제
echo 12. 디스크 사용량 확인
echo 13. 프로세스 종료
echo 14. 시스템 성능 모니터링
echo.

set /p choice="옵션 선택 (번호 입력 후 Enter): "

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

echo 잘못된 입력입니다. 다시 선택해 주세요.
timeout /t 2 >nul
goto menu

:run_c_bat
cls
echo 'little' 입력을 처리 중...
set "TARGET_DIR=%~dp0vv"
if exist "%TARGET_DIR%\c.bat" (
    echo c.bat 파일을 실행합니다...
    start "" "%TARGET_DIR%\c.bat"
) else (
    echo vv 폴더가 없거나 c.bat 파일이 존재하지 않습니다.
)
timeout /t 2 >nul
goto menu

:mic_on
echo 마이크를 켜는 중...
powershell -Command "Get-AppxPackage -AllUsers | Where-Object {$_.InstallLocation -match 'SystemSettings'} | ForEach-Object {& ($_.InstallLocation + '\SystemSettings.exe') -WindowStyle Hidden -ArgumentList 'page=MicrophonePrivacy'}"
timeout /t 2 >nul

pause
goto menu

:install_chrome
cls
echo 크롬 설치 시작
set "TARGET_DIR=%~dp0vv"

for /f "tokens=4-5 delims=[.] " %%i in ('ver') do set VERSION=%%i.%%j

if "%VERSION%"=="10.0" (
    echo Windows 10 감지됨 - Windows 10용 크롬 설치 시작
    start "" "%TARGET_DIR%\chrome_installer_win10.exe"
) else if "%VERSION%"=="6.1" (
    echo Windows 7 감지됨 - Windows 7용 크롬 설치 시작
    start "" "%TARGET_DIR%\chrome_installer_win7.exe"
) else (
    echo 지원되지 않는 Windows 버전입니다.
)

timeout /t 2 >nul
goto menu

:disk_cleanup
cls
echo 디스크 정리 실행 중...
cleanmgr /sagerun:1
timeout /t 2 >nul
goto menu

:flush_dns
cls
ipconfig /flushdns
echo DNS 캐시가 초기화되었습니다.
timeout /t 2 >nul
goto menu

:reset_network
cls
echo 네트워크 어댑터 초기화 중...
ipconfig /release 
ipconfig /renew 
echo 네트워크 어댑터가 초기화되었습니다.
timeout /t 2 >nul
goto menu

:restart_computer
cls
echo 컴퓨터를 재시작합니다...
shutdown /r /t 0
exit

:shutdown_computer
cls
echo 컴퓨터를 종료합니다...
shutdown /s /t 0
exit

:system_info
cls
echo 시스템 정보:
systeminfo
echo.
pause
goto menu

:process_list
cls
echo 현재 실행 중인 프로세스 목록:
tasklist
echo.
pause
goto menu

:check_updates
cls
echo 시스템 업데이트 확인 중...
powershell -Command "Get-WindowsUpdate"
echo.
pause
goto menu

:delete_temp_files
cls
echo 임시 파일 삭제 중...
del /q /f %temp%\*
timeout /t 2 >nul
goto menu

:check_disk_usage
cls
echo 디스크 사용량 확인 중...
wmic logicaldisk get size,freespace,caption
echo.
pause
goto menu

:kill_process
cls
set /p process_name="종료할 프로세스 이름을 입력하세요: "
taskkill /IM "%process_name%" /F
timeout /t 2 >nul
goto menu

:monitor_performance
cls
echo 시스템 성능 모니터링 중...
echo CPU 사용량:
wmic cpu get loadpercentage
echo 메모리 사용량:
systeminfo | findstr /C:"사용 가능한 물리적 메모리"
echo.
pause
goto menu

:end
cls
echo 프로그램을 종료합니다.
exit
