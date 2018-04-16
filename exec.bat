@echo off
if "%1"=="install" goto execute
if "%1"=="uninstall" goto execute
goto exit
:execute
  set reg=%1.reg
  (dump.bat %1 > %reg% && type %reg% && %reg% && del %reg%) ^
    || (del %reg% && pause)
:exit
