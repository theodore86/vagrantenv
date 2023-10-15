@echo off

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo You need administrative privileges to install chocolatey.
    echo .
    echo Please run this script as an administrator.
    echo .
    pause
    exit /b %errorlevel%
)

SET DIR=%~dp0%

echo Ensure that your cmd.exe runs as Administrator
echo .
echo If you are behind proxy SET HTTP(S)_PROXY or http(s)_proxy settings
echo .
pause

echo Running chocolatey installer (install.ps1)
echo .
pause
@powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command^
  "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"^
  || goto :error
SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

echo Installing project dependencies using chocolatey
echo .
pause
choco install -y %DIR%chocolatey.config || goto :error
call refreshenv

echo If it is the first time you are provisioning your system, perform an system reboot
echo .
pause

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%
