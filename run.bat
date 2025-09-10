@echo off
title PC-Booster v1.1
color a

echo =============================
echo     Advanced PC-Booster
echo =============================
echo Please run this file as Administrator!
echo.

echo [1/7] Cleaning temporary files...
del /q /f /s %TEMP%\* >nul 2>&1
rd /s /q %TEMP% >nul 2>&1
del /q /f /s C:\Windows\Temp\* >nul 2>&1
echo Done.
echo.

echo [2/7] Flushing DNS cache...
ipconfig /flushdns
echo Done.
echo.

echo [3/7] Cleaning Windows Update cache...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /q /f /s C:\Windows\SoftwareDistribution\Download\* >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo Done.
echo.

echo [4/7] Optimizing memory...
%windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks
echo Done.
echo.

echo [5/7] Optimizing disk...
defrag C: /O
echo Done.
echo.

echo [6/7] Clearing Prefetch files and Recycle Bin...
del /q /f /s C:\Windows\Prefetch\* >nul 2>&1
rd /s /q C:\$Recycle.Bin >nul 2>&1
echo Done.
echo.

echo [7/7] Running system file check...
sfc /scannow
echo Done.
echo.

echo ===========================================
echo   Extra: Network optimization
echo ===========================================
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global chimney=enabled
netsh int tcp set global dca=enabled
netsh int tcp set global rss=enabled
echo Network optimization completed.
echo.

echo ===========================================
echo   All optimizations completed!
echo   A restart is recommended to apply
echo   all changes successfully.
echo ===========================================
echo.

choice /c YN /m "Do you want to restart your PC now?"
if errorlevel 1 shutdown /r /t 5
