@echo off
title Instalador de drivers v0.1
color f0
setlocal enableDelayedExpansion

rem ========== CPU & Chipset ============
echo Instalando controladores de Chipset...
echo %PROCESSOR_IDENTIFIER% | find /I "GenuineAMD">nul && (
    echo 	Procesador Intel
) || (
	echo 	Procesador AMD
)

rem =============== GPU ================
echo Buscando controladores graficos para instalar...
for /f "tokens=2 delims=:" %%g in ('pnputil /enum-devices /connected') do (
	echo "%%g" | find /i "PCI\VEN_8086">nul && (
		echo "%%g" | find /i "DEV_9BC4">nul && (
			echo 	"Intel(R) UHD Graphics"
		)
		echo "%%g" | find /i "DEV_9B41">nul && (
			echo 	"Intel(R) UHD Graphics"
		)
		echo "%%g" | find /i "DEV_9BC5">nul && (
			echo 	"Intel(R) UHD Graphics 630"
		)
		echo "%%g" | find /i "DEV_9BC8">nul && (
			echo 	"Intel(R) UHD Graphics 630"
		)
	)
	echo "%%g" | find /i "PCI\VEN_10DE">nul && (
		echo "%%g" | find /i "DEV_1D01">nul && (
			echo 	"nVIDIA GeForce GT 1030"
		)
		echo "%%g" | find /i "DEV_1C82">nul && (
			echo 	"nVIDIA GeForce GTX 1050 Ti"
		)
		echo "%%g" | find /i "DEV_2188">nul && (
			echo 	"nVIDIA GeForce GTX 1650"
		)
		echo "%%g" | find /i "DEV_1F82">nul && (
			echo 	"nVIDIA GeForce GTX 1650"
		)
		echo "%%g" | find /i "DEV_2187">nul && (
			echo 	"nVIDIA GeForce GTX 1650 SUPER"
		)
	)
	echo "%%g" | find /i "PCI\VEN_1002">nul && (
		echo 	"Grafica AMD Radeon"
	)
)

rem =============== Office =====================


echo Controladores basicos instalados. Proceda a activar Office y Windows.
pause
