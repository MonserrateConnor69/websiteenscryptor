@echo off
title Basic Virus Removal Script
echo ========================================
echo Basic Virus Removal Script
echo ========================================

echo Terminating common suspicious processes...
set suspect_processes=virus.exe malware.exe trojan.exe unwanted.exe

for %%p in (%suspect_processes%) do (
    tasklist | findstr /i "%%p" >nul
    if %ERRORLEVEL% equ 0 (
        echo Detected running process: %%p. Attempting to terminate it...
        taskkill /f /im %%p >nul
        if %ERRORLEVEL% equ 0 (
            echo Successfully terminated: %%p
        ) else (
            echo Failed to terminate: %%p. Please check manually.
        )
    )
)

echo Cleaning temporary files...
del /s /f /q %temp%\*.* >nul
rd /s /q %temp% >nul
md %temp%
echo Temporary files have been cleaned.

echo Resetting the hosts file to default...
(
echo # Copyright (c) 1993-2009 Microsoft Corp.
echo #
echo # This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
echo #
echo # This file contains the mappings of IP addresses to host names. Each
echo # entry should be kept on an individual line. The IP address should
echo # be placed in the first column followed by the corresponding host name.
echo # The IP address and the host name should be separated by at least one
echo # space.
echo #
echo # Additionally, comments (such as these) may be inserted on individual
echo # lines or following the machine name denoted by a '#' symbol.
echo #
echo # For example:
echo #
echo #      102.54.94.97     rhino.acme.com          # source server
echo #       38.25.63.10     x.acme.com              # x client host
echo #
echo # localhost name resolution is handled within DNS itself.
echo #    127.0.0.1       localhost
echo #    ::1             localhost
) > %windir%\system32\drivers\etc\hosts
echo Hosts file reset complete.

echo Checking startup programs for suspicious entries...
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run > C:\startup_check.txt
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run >> C:\startup_check.txt
echo Startup programs have been listed in C:\startup_check.txt.
echo Review this file for any unknown or suspicious programs.

echo Cleaning common locations where malware might hide...
del /s /f /q C:\Windows\Temp\*.* >nul
rd /s /q C:\Windows\Temp >nul
md C:\Windows\Temp

del /s /f /q C:\Users\%username%\AppData\Local\Temp\*.* >nul
rd /s /q C:\Users\%username%\AppData\Local\Temp >nul
md C:\Users\%username%\AppData\Local\Temp

echo Common temporary locations have been cleaned.

echo ========================================
echo Cleanup and basic malware removal complete.
echo Review the output files for any remaining issues.
echo Consider running a full system scan with an updated antivirus.
echo ========================================
pause
exit
