@echo off
Reg add "HKCU\SOFTWARE\LovePE_Hub" /v "setting1" /t REG_DWORD /d "4" /f 1>nul
cd %~dp0
start ..\..\commond.exe  load ..\..\setting1.dll
exit