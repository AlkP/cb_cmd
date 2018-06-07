::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem ����� � ���箬 550 ���������
rem =========================================

rem ������� ��६�����
call :setVariable
rem �����஢����
call :decrypt
rem ���⨥ ������
call :verify
rem ����஢���
call :encrypt
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
set address=2008
if exist a: (subst a: /d)
exit /b 0

:decrypt
rem ======================================================================
echo  ** �����஢����
rem ======================================================================
set dirWorkEnd=550_decrypt\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (
  subst a: c:\key\550
  call %dirLib%lib.cmd "workWithVerbaKey %dirWork%%dirWorkEnd% decrypt -d"
  if exist a: (subst a: /d)
)
exit /b 0

:verify
rem ======================================================================
echo  ** ���⨥ ������
rem ======================================================================
set dirWorkEnd=550_verify\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (
  subst a: c:\key\550
  call %dirLib%lib.cmd "workWithVerbaKey %dirWork%%dirWorkEnd% verify -r"
  if exist a: (subst a: /d)
)
exit /b 0

:encrypt
rem ======================================================================
echo  ** ����஢���
rem �� �����: 7008
rem ======================================================================
set dirWorkEnd=550_encrypt\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (
  subst a: c:\key\550
  call %dirLib%lib.cmd "workWithVerbaKey %dirWork%%dirWorkEnd% encrypt -e#-a%address%"
  if exist a: (subst a: /d)
)
exit /b 0

:sign
rem ======================================================================
echo  ** ���⠢��� �������
rem ======================================================================
set dirWorkEnd=550_sign\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (
  subst a: c:\key\550
  call %dirLib%lib.cmd "workWithVerbaKey %dirWork%%dirWorkEnd% sign -s"
  if exist a: (subst a: /d)
)
exit /b 0

