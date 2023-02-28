@echo off

SET DIR=%~dp0%

echo Ensure that your cmd.exe runs as Administrator
echo .
echo If you are behind proxy SET HTTP(S)_PROXY settings
echo .
pause

echo Downloading install.ps1 (chocolatey installation script)
echo .
pause
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://chocolatey.org/install.ps1','%DIR%install.ps1'))" || goto :error

echo Running chocolatey installer (install.ps1)
echo .
pause
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%DIR%install.ps1' %*" || goto :error

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
