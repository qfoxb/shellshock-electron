:: Check for administrator permissions
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"    
where /q node || ECHO Cound not find node.js, Please install! && goto :end
echo This script will build Shell Shockers for Electron.
echo Version: 1.1
where /q nativefier || ECHO Could not find nativefier on PATH. Installing... && npm install nativefier -g
set /P c=Which Platform are you trying to build for?[win64/win32/mac/linux64/all]?
if /I "%c%" EQU "win64" goto :win64
if /I "%c%" EQU "win32" goto :win32
if /I "%c%" EQU "mac" goto :darwin
if /I "%c%" EQU "linux64" goto :x8664
if /I "%c%" EQU "all" goto :all

:win64
nativefier --update --name "Shell Shockers" --arch x64 --platform windows --electron-version 18.2.1 --user-agent firefox  --internal-urls "(.*?accounts\.google\.com.*?|.*?shellshockio-181719\.firebaseapp\.com.*?)" --single-instance  https://shellshock.io --verbose
pause
goto :end
:win32
nativefier --update --name "Shell Shockers" --arch ia32 --platform windows --electron-version 18.2.1 --user-agent firefox  --internal-urls "(.*?accounts\.google\.com.*?|.*?shellshockio-181719\.firebaseapp\.com.*?)" --single-instance  https://shellshock.io --verbose
pause
goto :end
:darwin
nativefier --update --name "Shell Shockers" --arch universal --platform darwin --darwin-dark-mode-support --fast-quit --electron-version 18.2.1 --user-agent firefox  --internal-urls "(.*?accounts\.google\.com.*?|.*?shellshockio-181719\.firebaseapp\.com.*?)" --single-instance  https://shellshock.io --verbose
pause
goto :end
:x8664
nativefier --update --name "Shell Shockers" --arch x64 --platform linux --electron-version 18.2.1 --user-agent firefox  --internal-urls "(.*?accounts\.google\.com.*?|.*?shellshockio-181719\.firebaseapp\.com.*?)" --single-instance  https://shellshock.io --verbose
:all
nativefier --update --name "Shell Shockers" --arch x64 --platform windows --electron-version 18.2.1 --user-agent firefox  --internal-urls "(.*?accounts\.google\.com.*?|.*?shellshockio-181719\.firebaseapp\.com.*?)" --single-instance  https://shellshock.io --verbose
nativefier --update --name "Shell Shockers" --arch ia32 --platform windows --electron-version 18.2.1 --user-agent firefox  --internal-urls "(.*?accounts\.google\.com.*?|.*?shellshockio-181719\.firebaseapp\.com.*?)" --single-instance  https://shellshock.io --verbose
nativefier --update --name "Shell Shockers" --arch x64 --platform darwin --darwin-dark-mode-support --fast-quit --electron-version 18.2.1 --user-agent firefox  --internal-urls "(.*?accounts\.google\.com.*?|.*?shellshockio-181719\.firebaseapp\.com.*?)" --single-instance  https://shellshock.io
nativefier --update --name "Shell Shockers" --arch x64 --platform linux --electron-version 18.2.1 --user-agent firefox  --internal-urls "(.*?accounts\.google\.com.*?|.*?shellshockio-181719\.firebaseapp\.com.*?)" --single-instance  https://shellshock.io --verbose
goto :end
pause
:end
pause