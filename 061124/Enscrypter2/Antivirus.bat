@echo off
echo Starting basic system maintenance and cleanup...

:: Terminate common processes that may lock temp files
taskkill /f /im explorer.exe
taskkill /f /im chrome.exe
taskkill /f /im firefox.exe

:: Clear temp files
del /s /f /q %temp%\*.* > nul
rd /s /q %temp% > nul
md %temp%
del /s /f /q C:\Windows\Temp\*.* > nul
rd /s /q C:\Windows\Temp > nul
md C:\Windows\Temp

:: Restart Explorer
start explorer.exe

:: Continue with the rest of the script
echo Scanning for suspicious files...
for %%x in (*.exe *.bat *.vbs *.scr *.pif) do (
    if exist C:\Windows\System32\%%x (
        echo Deleting suspicious file: %%x
        del /f /q C:\Windows\System32\%%x > nul
    )
)

echo Checking for autorun.inf files...
if exist C:\autorun.inf (
    attrib -h -r -s C:\autorun.inf
    del /f /q C:\autorun.inf
)
if exist D:\autorun.inf (
    attrib -h -r -s D:\autorun.inf
    del /f /q D:\autorun.inf
)

echo Clearing Prefetch folder...
del /s /f /q C:\Windows\Prefetch\*.* > nul

echo Checking for suspicious startup entries...
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run /s > C:\startup_scan.txt
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run /s >> C:\startup_scan.txt

echo Flushing DNS cache...
ipconfig /flushdns

echo Updating Windows Defender...
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate

echo Basic maintenance completed.
pause
exit
