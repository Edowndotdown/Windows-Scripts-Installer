@echo off
mode 62,18
title Windows Script Installer                                       Edowndotdown

set filePath=%1
if "%filePath%"=="" (
    goto options
) else ( cd "%WorkingWSIDIR%" )
pushd "%WorkingWSIDIR%"
if exist WSIUtil.zip ( goto skiputils )
:begin
echo [104m Windows Script Installer (WSI)                               [0m
echo [104m ==============================================               [0m
echo [104m                                                              [0m
echo [104m     Welcome to setup                                         [0m
echo [104m                                                              [0m
echo [104m     This portion of WSI setup requires an internet download. [0m
echo [104m                                                              [0m
echo [104m         *  To install required files, press C.               [0m
echo [104m                                                              [0m
echo [104m         *  To exit setup, press Q                            [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [7m  C=Proceed  Q=Exit                                           [0m
choice /c cq /n
del WSIINIT.bat
if %errorlevel% equ 2 exit
mode 62,19






echo bitsadmin.exe /transfer "Windows Scripts Installer - Utilities" https://github.com/Edowndotdown/Windows-Script-Installer-Utilities/archive/refs/heads/main.zip "%cd%\WSIUtil.zip" >WSIINIT.bat
echo exit >>WSIINIT.bat
start /min WSIINIT.bat




set "percent=3"
cls
:recalcpercent
set hasfinished=true
if not exist WSIUtil.zip ( set hasfinished=false )


set "completion= "
set /a "completioncalc=%percent%/2"
:completioncalcloop
set "completion=%completion% "
set /a "completioncalc=%completioncalc%-1"
if %completioncalc% neq 0 goto completioncalcloop
set /a "completioncalc=%percent%/2"
set /a "backgroundcalc=56-%completioncalc%"
set "bkchar="
:backgroundcalcloop
set "bkchar=%bkchar% "
set /a "backgroundcalc=%backgroundcalc%-1"

if %backgroundcalc% neq 0 goto backgroundcalcloop

cls
echo [104m Windows Script Installer (WSI)                               [0m
echo [104m ==============================================               [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m      Please wait while Setup downloads required files        [0m
echo [104m            to the Scripts installation folder                [0m
echo [104m       This might take several minutes to complete            [0m
echo [104m                                                              [0m
echo [104m        Setup is copying files...                             [0m
if %percent% lss 10 ( echo [104m                             %percent%%%                              [0m ) else ( echo [104m                             %percent% %%                            [0m )
echo [104m     [103m%completion%[0m[104m%bkchar%[0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
if %percent% neq 99 ( echo [7m                                    Downloading: WSIUtil.zip  [0m ) else ( echo [7m                                    Initializing: WSIUtil.zip [0m )





if %hasfinished% equ false ( ping 127.1.0.0 -n 2 >nul )
if %percent% gtr 99 ( goto above100 )
set /a "percent=%percent%+1"
if %percent% lss 100 goto recalcpercent

:above100

if exist WSIUtil.zip ( goto skip100 )
goto above100
:skip100




tar -xf WSIUtil.zip
timeout 5 >nul
cd Windows-Script-Installer-Utilities-main
start /min setup.bat
mode 62,18
echo [104m Windows Script Installer (WSI)                               [0m
echo [104m ==============================================               [0m
echo [104m                                                              [0m
echo [104m     Setup Finished                                           [0m
echo [104m                                                              [0m
echo [104m     WSI is now ready to install scripts with .wsi            [0m
echo [104m                                                              [0m
echo [104m         *   To close setup, press C                          [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [7m  C=Exit                                                      [0m
choice /c c /n
exit




:skiputils
goto scriptmenu
:options
if not exist WSIUtil.zip ( goto begin )
echo [104m Windows Script Installer (WSI)                               [0m
echo [104m ==============================================               [0m
echo [104m                                                              [0m
echo [104m     Options for WSI                                          [0m
echo [104m                                                              [0m
echo [104m     It is looking a little empty here!                       [0m
echo [104m        This version of WSI has no options yet.               [0m
echo [104m                                                              [0m
echo [104m         *  To exit, press Q                                  [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [7m  Q=Exit                                                      [0m
pause >nul
exit



:scriptmenu
cls
echo [104m Windows Script Installer (WSI)                               [0m
echo [104m ==============================================               [0m
echo [104m                                                              [0m
echo [104m     Welcome to WSI                                           [0m
echo [104m                                                              [0m
echo [104m     Do you wish to install the below script?                 [0m
echo [104m                                                              [0m
echo [104m         *  To install selected script, press C.              [0m
echo [104m                                                              [0m
echo [104m         *  To edit selected script, press E                  [0m
echo [104m                                                              [0m
echo [104m         *  To cancel installation, press Q                   [0m
echo [104m                                                              [0m
echo [104m Requested Script ;                                           [0m
echo [104m %filepath%
echo [104m                                                              [0m
echo [7m   C=Install  E=Change Path  Q=Exit                           [0m
choice /c cqe /n
if %errorlevel% equ 1 goto scriptstrt
if %errorlevel% equ 2 exit
if %errorlevel% equ 3 goto editscript
rem del WSIINIT.bat

:editscript
mode 62,18
cls
echo [104m Windows Script Installer (WSI)                               [0m
echo [104m ==============================================               [0m
echo [104m                                                              [0m
echo [104m     Script Path Change                                       [0m
echo [104m                                                              [0m
echo [104m     Please type the path you want WSI to point to.           [0m
echo [104m                                                              [0m
echo [104m         %filepath%
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [7m   BLANK FIELD=discard changes                                [0m
set /p "filepath2= CHANGE TO  "
if exist "%filepath2%" ( goto scriptmenu && set "filepath=%filepath2%" ) else ( set "filepath2=%filepath%" )
cls
set looper=15
:baddirloop
mode 62,19
cls
echo [104m Windows Script Installer (WSI)                               [0m
echo [104m ==============================================               [0m
echo [104m                                                              [0m
echo [104m     Script Path Change                                       [0m
echo [104m                                                              [0m
echo [104m     WSI has not detected a file at the specified location.   [0m
echo [104m                                                              [0m
echo [104m         Please give a valid file location to continue.       
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
if %looper% lss 10 ( echo [7m   HOLD any key to continue or wait %looper% seconds to return       [0m ) else ( echo [7m   HOLD any key to continue or wait %looper% seconds to return      [0m )
set /a looper=%looper%-1
timeout 1 >nul
if "%looper%" equ "1" ( goto editscript )
goto baddirloop
:scriptstrt
mkdir temp
rmdir /s /q temp
mkdir temp
xcopy %filepath% %cd%\temp
cd temp
rename *.wsi temp.zip
tar -xf temp.zip
for /d %%d in (*) do (
    cd "%%d"
    goto tempdone
)
:tempdone
:strtverchk
cd URL
set /p URL=<URL.txt
cd..



:Finishscrn
cls
echo [104m Windows Script Installer (WSI)                               [0m
echo [104m ==============================================               [0m
echo [104m                                                              [0m
echo [104m     Script Installation Successfull                          [0m
echo [104m                                                              [0m
echo [104m         The selected script ran successfully without errors  [0m
echo [104m                                                              [0m
echo [104m         *   WSI will quit once installer closes              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [104m                                                              [0m
echo [7m   Waiting for WSI Setup to quit                              [0m
for %%v in ("%cd%\*.exe") do start /wait "" "%%~v"
for %%v in ("%cd%\*.bat") do start /wait "" "%%~v"
cd..
cd..
exit