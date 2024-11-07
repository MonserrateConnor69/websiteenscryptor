@echo off
title Keylogger Protection Tool

echo ============================
echo Keylogger Protection Tool
echo ============================

:: Check for suspicious processes
echo Checking for suspicious processes...
tasklist | findstr /i /c:"keylogger" /c:"logger" /c:"recorder" /c:"stealer" > C:\keylogger_suspects.txt

if %ERRORLEVEL% equ 0 (
    echo Potential keylogging processes detected. Please review C:\keylogger_suspects.txt.
) else (
    echo No suspicious processes detected.
)

:: List startup programs
echo Checking startup programs...
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run > C:\startup_check.txt
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run >> C:\startup_check.txt

echo Startup program list has been saved to C:\startup_check.txt.
echo Please review the file for any unfamiliar entries.

:: Monitor common keylogger directories for new files
echo Monitoring for unusual file changes in common directories...
dir /s /b C:\Users\%username%\AppData\Local\Temp\ > C:\temp_files_before.txt
timeout /t 10 >nul
dir /s /b C:\Users\%username%\AppData\Local\Temp\ > C:\temp_files_after.txt
fc C:\temp_files_before.txt C:\temp_files_after.txt > C:\temp_files_changes.txt

if %ERRORLEVEL% equ 0 (
    echo No unusual changes in temporary files detected.
) else (
    echo Warning: New files detected in the Temp folder. Review C:\temp_files_changes.txt.
)


pause
exit
