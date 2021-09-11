@echo off
cd /d "%~dp0" && (if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs") && fsutil dirty query %systemdrive% 1>nul 2>nul || (cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
setlocal enableDelayedExpansion
title Instalador desatendido v0.1 by Rob
color f0

echo ========== Determinando fabricante de Chipset...
echo %PROCESSOR_IDENTIFIER% | find /i "GenuineIntel">nul && (
	echo 	Chipset INTEL...
	%~d0\Drivers\Intel\Chipset\setup.exe -s -norestart
)
echo %PROCESSOR_IDENTIFIER% | find /i "AuthenticAMD">nul && (
	echo 	Chipset AMD...
	%~d0\Drivers\AMD\Chipset\setup.exe -install
)
echo 	Hecho.

echo ========== Determinando tarjeta de video...
for /f "tokens=4" %%a in ('pnputil /enum-devices /connected ^| find /i "PCI\"') do (
	set hw_id=%%a
	set hw_id=!hw_id:~4,17!
	for /f "tokens=*" %%b in ('findstr /i "!hw_id!" db.txt') do (
		for /f "tokens=3 delims==" %%c in ("%%b") do (
			echo %%c
			%%c
		)
	)
)

echo ========== Instalando Office...
%~d0\OFFICE_2013\setup.exe
rem TODO: hacer instalador desatendido sin usar "config.xml"
echo 	Hecho.

echo ========== Estableciendo fondo de pantalla. De no ocurrir, hagalo manualmente.
set /a wallpp_num=%RANDOM%*9/32768+1
copy %~d0\FONDO_XT\BackgroundXtreme%wallpp_num%.bmp %USERPROFILE%\Pictures
REM timeout 10
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d %USERPROFILE%\Pictures\BackgroundXtreme%wallpp_num%.bmp /f
REM timeout 2
%SystemRoot%\System32\RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters

echo 	Hecho. Proceda a activar Windows y Office.
pause
