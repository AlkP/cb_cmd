::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem ��ࠡ�⪠ ��娢��
rem =========================================

rem ������� ��६�����
call :setVariable
rem �����娢�஢���� ��� ��娢��
call :extract
rem ��७�� ࠧ��娢�஢���� 䠩��� �� �室��� ��⠫��
call :moveAfterExtract
rem �����娢�஢���� ��� ��娢�� ᮤ�ঠ騥 �㡫�
call :extractRR

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>










































:setVariable
rem ======================================================================
echo  ** ������� ��६�����
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

set       arjIn=c:\work\from_arj\in\
set      arjOut=c:\work\from_arj\out\

set       dirIn=c:\work\cb_check\ok\
set     dirInRR=c:\work\cb_check\re_receipt\
set  dirArjInRR=c:\work\from_arj_re_receipt\in\
set dirArjOutRR=c:\work\from_arj_re_receipt\out\

exit /b 0

:extract
rem ======================================================================
echo  ** �����娢�஢���� ��� ��娢��
rem + �������� ����� �ਣ����� ��娢� � bck
rem ======================================================================
where /r %arjIn% /q *.arj > nul
if not errorlevel 1 (call %dirLib%lib.cmd "extractFromArj %arjIn% %arjOut% *.arj")
exit /b 0


:moveAfterExtract
rem ======================================================================
echo  ** ��७�� ࠧ��娢�஢���� 䠩��� �� �室��� ��⠫��
rem ======================================================================
where /r %arjOut% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %arjOut% %dirIn% * moveAfterExtract")
exit /b 0

:extractRR
rem ======================================================================
echo  ** �����娢�஢���� ��� ��娢�� ᮤ�ঠ騥 �㡫�
rem + �������� ����� �ਣ����� ��娢� � bck
rem ======================================================================
where /r %dirArjInRR% /q *.arj > nul
if not errorlevel 1 (call %dirLib%lib.cmd "extractFromArjRR %dirArjInRR% %dirArjOutRR% %dirIn% %dirInRR% *.arj")
exit /b 0
