@echo off
echo System Checks Running...
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if "%1" neq "" goto :AfterReboot%1
cls
:start
echo Adding Registry Keys... 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v "Exec_AfterReboot" /t REG_SZ /d "%~0 1" /f >Nul
cls
echo Scanning System Files
sfc /scannow
echo Restarting...
pause
shutdown /r /t 0
exit

:AfterReboot1
echo Reboot Complete,
pause
cls
echo Running Deployment Image Servicing and Management tool
DISM /Online /Cleanup-Image /RestoreHealth 
cls
echo Scanning System Files
sfc /scannow
echo Done!
pause
exit
