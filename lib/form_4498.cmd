::<<<<<<<<<<<<<<<<F<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem ��ࠡ�⪠ 䠩��� �� �ଥ 4498
rem =========================================

rem ������� ��६�����
call :setVariable

rem ��ࠢ�� ��娢�� ARHOS*.arj �� �����ᠭ��
rem call :move_arj_to_sign
rem ��ࠢ�� ��娢�� ARHOS*.arj � ��
call :send_arj_to_CB


exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>






























:setVariable
rem ======================================================================
echo  ** ������� ��६�����
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"
exit /b 0

:move_arj_to_sign
rem ======================================================================
echo  ** ��ࠢ�� ��娢�� ARHOS*.arj �� �����ᠭ��
rem ======================================================================
setlocal
set /a decada=%date:~0,2% / 10
set from=v:\to_cb\4498U\%date:~6,4%\%date:~3,2%\0%decada%
set   to=c:\work\processing\sign_sign\in\
set mask=ARHOS*.arj
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %dirBck% %to% %mask% toBck toSign")
endlocal&exit /b 0

:send_arj_to_CB
rem ======================================================================
echo  ** ��ࠢ�� ��娢�� ARHOS*.arj � ��
rem ======================================================================
setlocal
set from=c:\work\processing\sign_sign\out\
set   to=t:\toCB\in\
set mask=ARHOS*.arj
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toCB")
endlocal&exit /b 0


