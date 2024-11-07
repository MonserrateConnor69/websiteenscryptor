@echo off
title Remote Control Detection and Blocking Tool

echo ============================================
echo Remote Control Detection and Blocking Tool
echo ============================================

:: Define common remote control software process names
set remote_processes=TeamViewer.exe AnyDesk.exe LogMeIn.exe mstsc.exe VNCServer.exe VNCViewer.exe RemotePC.exe ChromeRemoteDesktopHost.exe Supremo.exe

:: Check for known remote access processes and kill them
echo Scanning for known remote control software...

for %%p in (%remote_processes%) do (
    tasklist | findstr /i "%%p" >nul
    if %ERRORLEVEL% equ 0 (
        echo Detected running process: %%p. Attempting to terminate it...
        taskkill /f /im %%p >nul
        if %ERRORLEVEL% equ 0 (
            echo Successfully terminated: %%p
        ) else (
            echo Failed to terminate: %%p. Please close it manually.
        )
    )
)

:: Check for active Remote Desktop (RDP) connections
echo Checking for active RDP sessions...
query user | findstr /i "rdp-tcp" >nul
if %ERRORLEVEL% equ 0 (
    echo Warning: Active RDP session detected. It is recommended to disconnect if unauthorized.
) else (
    echo No active RDP sessions detected.
)

:: Check for common remote control ports being open
echo Scanning for common remote control ports (3389, 5938, 443, 5939, 5500)...
netstat -ano | findstr :3389 > C:\remote_ports.txt
netstat -ano | findstr :5938 >> C:\remote_ports.txt
netstat -ano | findstr :443 >> C:\remote_ports.txt
netstat -ano | findstr :5939 >> C:\remote_ports.txt
netstat -ano | findstr :5500 >> C:\remote_ports.txt

if exist C:\remote_ports.txt (
    echo Possible open ports for remote control detected. Please review C:\remote_ports.txt for details.
) else (
    echo No suspicious open ports detected.
)

:: Inform user of next steps
echo ============================================
echo Review the detected processes and open ports.
echo If any remote access was unauthorized, ensure it is properly blocked.
echo Consider using a firewall to restrict incoming remote connections.
echo ============================================

pause
exit
