@REM Not working
@REM encoding: GBK
@echo off
set regPath="HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
for /f "usebackq tokens=2*" %%a in (`reg query %regPath% /v AppsUseLightTheme ^| find "REG_DWORD"`) do set currentMode=%%b

if "%currentMode%"=="0x1" (
    reg add %regPath% /v AppsUseLightTheme /t REG_DWORD /d 0 /f >nul
) else (
    reg add %regPath% /v AppsUseLightTheme /t REG_DWORD /d 1 /f >nul
)
