::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem ���� �㦡: �������
rem =========================================

rem ������� ��६�����
call :setVariable
rem ���⨥ ������
call :verify
rem ���⠢��� �������
call :sign

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>












































:setVariable
rem ======================================================================
echo  ** ������� ��६�����
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"
if exist a: (subst a: /d)
exit /b 0

:verify
rem ======================================================================
echo  ** ���⨥ ������
rem ======================================================================
set dirWorkEnd=sign_verify\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (
  subst a: c:\key\sign
  call %dirLib%lib.cmd "workWithVerbaKey %dirWork%%dirWorkEnd% verify -r"
  if exist a: (subst a: /d)
)
exit /b 0

:sign
rem ======================================================================
echo  ** ���⠢��� �������
rem ======================================================================
set dirWorkEnd=sign_sign\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (
  subst a: c:\key\sign
  call %dirLib%lib.cmd "workWithVerbaKey %dirWork%%dirWorkEnd% sign -s"
  if exist a: (subst a: /d)
)
exit /b 0
