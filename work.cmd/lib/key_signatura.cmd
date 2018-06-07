::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem ����� � ���箬 Signatura
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
if exist a: (subst a: /d)
exit /b 0

:decrypt
rem ======================================================================
echo  ** �����஢����
rem ======================================================================
set dirWorkEnd=signatura_decrypt\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "workWithSignaturaKey %dirWork%%dirWorkEnd% decrypt !d")
exit /b 0

:verify
rem ======================================================================
echo  ** ���⨥ ������
rem ======================================================================
set dirWorkEnd=signatura_verify\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "workWithSignaturaKey %dirWork%%dirWorkEnd% verify !v")
exit /b 0

:encrypt
rem ======================================================================
echo  ** ����஢���
rem ======================================================================
set dirWorkEnd=signatura_encrypt\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "workWithSignaturaKey %dirWork%%dirWorkEnd% encrypt !e")
exit /b 0

:sign
rem ======================================================================
echo  ** ���⠢��� �������
rem ======================================================================
set dirWorkEnd=signatura_sign\
where /r %dirWork%%dirWorkEnd%in\ /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "workWithSignaturaKey %dirWork%%dirWorkEnd% sign !s")
exit /b 0
