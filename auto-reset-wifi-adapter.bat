@echo off

set TARGET=8.8.8.8

REM Set the name of your Wi-Fi adapter (get the name from 'netsh interface show interface')
set INTERFACE_NAME="Wi-Fi"

:loop
REM Ping the target with 1 attempt and wait 2 seconds for a response
ping -n 1 -w 2000 %TARGET% > nul

REM If ping fail, restart the Wi-Fi adapter
if errorlevel 1 (
    echo Network is down %time%. restarting the Wi-Fi adapter...
    netsh interface set interface %INTERFACE_NAME% admin=disable
    timeout /t 3 > nul
    netsh interface set interface %INTERFACE_NAME% admin=enable
    echo Wi-Fi adapter reset complete.
) else (
    echo Network is up - %time%.
)

REM Wait for 5 seconds before checking again
timeout /t 5 > nul

goto loop
