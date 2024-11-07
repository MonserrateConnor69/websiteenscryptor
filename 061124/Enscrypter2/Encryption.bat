@echo off
:: Simple Batch Script to Encrypt and Hide Files
:: Note: This script provides basic encryption using Windows' built-in tools.
:: For stronger encryption, use third-party software.

:: Set a password for script access
set /p "password=Enter password to continue: "
if NOT %password%==YourPasswordHere (
    echo Incorrect password. Exiting...
    pause
    exit
)

:: Start Encryption and Protection
echo Encrypting and protecting files...

:: Encrypt specific folders (change the path as needed)
cipher /e /s:"C:\Users\%username%\Documents\ImportantFiles"
cipher /e /s:"C:\Users\%username%\Pictures\PrivatePhotos"

:: Hide specific folders using attrib (change paths as needed)
attrib +h +s "C:\Users\%username%\Documents\ImportantFiles"
attrib +h +s "C:\Users\%username%\Pictures\PrivatePhotos"

:: Confirmation message
echo Encryption and protection complete.
echo Your files are encrypted and hidden.

pause
exit
