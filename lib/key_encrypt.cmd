::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem Ключ служб: шифрование
rem =========================================

rem Задание переменных
call :setVariable
rem Расшифрование
call :decrypt
rem Зашифровать
call :encrypt

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>












































:setVariable
rem ======================================================================
echo  ** Задание переменных
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"
set address=2010
if exist a: (subst a: /d)
exit /b 0


:decrypt
rem ======================================================================
echo  ** Расшифрование
rem ======================================================================
set dirWorkEnd=encrypt_decrypt\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (
  subst a: c:\key\encrypt
  call %dirLib%lib.cmd "workWithVerbaKey %dirWork%%dirWorkEnd% decrypt -d"
  if exist a: (subst a: /d)
)
exit /b 0

:encrypt
rem ======================================================================
echo  ** Зашифровать
rem на адресата: 7020
rem ======================================================================
set dirWorkEnd=encrypt_encrypt\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (
  subst a: c:\key\encrypt
  call %dirLib%lib.cmd "workWithVerbaKey %dirWork%%dirWorkEnd% encrypt -e#-a%address%"
  if exist a: (subst a: /d)
)
exit /b 0

:finish

