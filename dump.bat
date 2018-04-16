@echo off
set esc=
:: Note that "HKCR:\Directory\Background\shell\cmd" is used by default
set norm_hive=HKEY_CLASSES_ROOT\Directory\Background\shell\command_prompt
set admin_hive=HKEY_CLASSES_ROOT\Directory\Background\shell\command_prompt_admin
if "%1"=="install" goto install
if "%1"=="uninstall" goto uninstall
echo %esc%[101;93mInvalid parameter: %1%esc%[0m >&2
pause
goto exit
:install
  for %%I in (cmd.exe) do set exepath=%%~$PATH:I
  if "%exepath%"=="" (
    echo %esc%[101;cmd.exe not found%esc%[0m >&2
    exit /b 1
  )
  set exepath=%exepath:\=\\%
  echo Windows Registry Editor Version 5.00
  echo.
  echo [%norm_hive%]
  echo @="&Command Prompt"
  echo "Icon"="%exepath%"
  echo.
  echo [%norm_hive%\command]
  echo @="%exepath%"
  echo.
  echo [%admin_hive%]
  echo @="&Command Prompt (Administrator)"
  echo "Icon"="%exepath%"
  echo.
  echo [%admin_hive%\command]
  echo @="powershell -noprofile -nologo -noninteractive -windowstyle hidden -command start cmd ('/K', 'cd', \"$pwd\") -verb runas"
  goto exit
:uninstall
  echo Windows Registry Editor Version 5.00
  echo.
  echo [-%norm_hive%]
  echo.
  echo [-%norm_hive%\command]
  echo.
  echo [-%admin_hive%]
  echo.
  echo [-%admin_hive%\command]
:exit
