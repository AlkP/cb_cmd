::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem �஢�ઠ 䠩��� �� 㭨���쭮���, ��ࢨ筠� ��ࠡ�⪠
rem =========================================

rem ������� ��६�����
call :setVariable
rem �஢�ઠ 㭨���쭮�� ����� �� 䠩�� �� ����
call :checkIncomingForReReceipt
rem �஢�ઠ 㭨���쭮�� ����� ��� 䠩��� �� ����
call :checkOutcomingForReReceipt
rem �஢��塞, �� �� 䠩� 㦥 ��ࠡ�⠭ � �����頥� �㡫� � ࠡ���
call :moveInRR
rem �஢��塞, �� ��� 䠩� 㦥 ��ࠡ�⠭ � �����頥� �㡫� � ࠡ���
call :moveOutRR
rem �����㥬 ��娢�:
call :sortArj

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>






































:setVariable
rem ======================================================================
echo  ** ������� ��६�����
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

exit /b 0

:checkIncomingForReReceipt
rem ======================================================================
echo  ** �஢�ઠ 㭨���쭮�� ����� �� 䠩�� �� ����
rem dirIn   - �� ��⠫��
rem dirInOK - ��⠫�� ��� 㭨������ 䠩���
rem dirInRR - ��⠫�� ��� �㡫�� 䠩���
rem ======================================================================
setlocal
set      dirIn=c:\work\cb\in\
set    dirInOK=c:\work\cb_check\ok\
set    dirInRR=c:\work\cb_check\re_receipt\
where /r %dirIn% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "checkUniqueness %dirIn% %dirInOK% %dirInRR% *")
endlocal&exit /b 0

:checkOutcomingForReReceipt
rem ======================================================================
echo  ** �஢�ઠ 㭨���쭮�� ����� ��� 䠩��� �� ����
rem dirOut   - �� ��⠫��
rem dirOutOK - ��⠫�� ��� 㭨������ 䠩���
rem dirOutRR - ��⠫�� ��� �㡫�� 䠩���
rem ======================================================================
setlocal
set     dirOut=c:\work\diasoft\out\
set   dirOutOK=c:\work\diasoft_check\ok\
set   dirOutRR=c:\work\diasoft_check\re_receipt\
where /r %dirOut% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "checkUniqueness %dirOut% %dirOutOK% %dirOutRR% *")
endlocal&exit /b 0

:moveInRR
rem ======================================================================
echo  ** �஢��塞, �� �� 䠩� 㦥 ��ࠡ�⠭ � �����頥� �㡫� � ࠡ���
rem ======================================================================
setlocal
set    dirInRR=c:\work\cb_check\re_receipt\
set    dirInOK=c:\work\cb_check\ok\
where /r %dirInRR% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "checkUniquenessRR %dirInRR% %dirInOK%")
endlocal&exit /b 0

:moveOutRR
rem ======================================================================
echo  ** �஢��塞, �� ��� 䠩� 㦥 ��ࠡ�⠭ � �����頥� �㡫� � ࠡ���
rem ======================================================================
setlocal
set   dirOutRR=c:\work\diasoft_check\re_receipt\
set   dirOutOK=c:\work\diasoft_check\ok\
where /r %dirOutRR% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "checkUniquenessRR %dirOutRR% %dirOutOK% inOutgoing")
endlocal&exit /b 0

:sortArj
rem ======================================================================
echo  ** �����㥬 ��娢�:
rem dirInOK - ��⠫�� ��� 㭨������ 䠩���
rem dirArjIn   - ��� ��娢�� � ������ ��� �㡫��
rem dirArjInRR - ��� ��娢�� � ������ ᮤ�ঠ��� 䠩�� ����� 㦥 ��ࠡ�⢠���� �� ����
rem ======================================================================
setlocal
set    dirInOK=c:\work\cb_check\ok\
set   dirArjIn=c:\work\from_arj\in\
set dirArjInRR=c:\work\from_arj_re_receipt\in\
set    maskArj=*.arj
where /r %dirInOK% /q %maskArj% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "checkUniquenessArj %dirInOK% %dirArjIn% %dirArjInRR% %maskArj%")
endlocal&exit /b 0
