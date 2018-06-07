::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem ��६�饭�� 䠩��� ����� Diasoft � ��⥬��
rem =========================================

rem ������� ��६�����
call :setVariable
rem ��६�頥� 䠩�� �� ������ � ��.TEMP_440
call :move_from_Diasoft
rem ��२��������� ????_????3510123_*.xml 䠩��� � ????_????3510123_*.vrb
rem call :rename_from_Diasoft
rem ��६�頥� 䠩�� ????3510123*.VRB �� �� � ������
call :move_request_to_Diasoft
rem ��६�頥� 䠩�� KWTFCB_*.xml �� �� � ������
call :move_KWTFCB_to_Diasoft
rem ��६�頥� 䠩�� 311p �� �� � ������
call :move_311_to_Diasoft
rem ��६�頥� 䠩�� 311p �� ������ � ��.TEMP_311
call :move_311_from_Diasoft_to_Temp
rem ��६�頥� 䠩�� 311p �訡��� ���⭮ � ������
call :move_311_err_to_Diasoft
rem ��६�頥� 䠩�� 311p �� ������ � ��
call :move_311_from_Diasoft_to_CB

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


































:setVariable
rem ======================================================================
echo  ** ������� ��६�����
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

exit /b 0

:move_from_Diasoft
rem ======================================================================
echo  ** ��६�頥� 䠩�� �� ������ � ��.TEMP_440
rem ======================================================================
setlocal
set    dirDiasoftOut=N:\exchange\440p\BRANCHES\0000\OUT\
set dirSystemOut440p=c:\work\diasoft\TEMP_440\

rem ������ �����������, ��⮬� ���⠤���⭠� �奬� �஢�ન ������ 䠩���
dir %dirDiasoftOut%* /a-d 2>nul >nul && goto :move_request_to_Diasoft_success
endlocal&exit /b 0
:move_request_to_Diasoft_success
call %dirLib%lib.cmd "moveFile %dirDiasoftOut% %dirSystemOut440p% *.xml fromDiasoft"
endlocal&exit /b 0

:rename_from_Diasoft
rem ======================================================================
echo  ** ��२��������� ????_????3510123_*.xml 䠩��� � ????_????3510123_*.vrb
rem ======================================================================
setlocal
set dirSystemOut440p=c:\work\diasoft\out_440p\
set     dirSystemOut=c:\work\diasoft\out\
set       fileMask=PB?_????3510123_*.xml#????_????3510123_*.vrb
rem set       fileMaskPB=PB?_????3510123_*.xml
rem set   fileMaskAnswer=????_????3510123_*.vrb
set fileMaskToRename=????_????3510123_*.xml
where /r %dirSystemOut440p% /q * > nul
if not errorlevel 1 (
  ren %dirSystemOut440p%%fileMaskToRename% *.vrb
  call %dirLib%lib.cmd "moveFile %dirSystemOut440p% %dirSystemOut% %fileMask% fromDiasoft"
rem   call %dirLib%lib.cmd "moveFile %dirSystemOut440p% %dirSystemOut% %fileMaskPB% fromDiasoft"
rem   call %dirLib%lib.cmd "moveFile %dirSystemOut440p% %dirSystemOut% %fileMaskAnswer% fromDiasoft"
)
endlocal&exit /b 0

:move_request_to_Diasoft
rem ======================================================================
echo  ** ��६�頥� 䠩�� ????3510123*.VRB �� �� � ������
rem ����⢨� �믮������ ⮫쪮 ��� �ᯨᠭ��: schedule01dweek & schedule01time
rem ======================================================================
setlocal
set      dirSystemIn=c:\work\diasoft\in\
set     dirDiasoftIn=N:\exchange\440p\BRANCHES\0000\IN\
set fileMaskRequestIn=????3510123*.VRB
where /r %dirSystemIn% /q %fileMaskRequestIn% > nul
if errorlevel 1 (endlocal&exit /b 0)
rem call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule03dweek% %schedule05time%"
rem if %checkResult% EQU true (
call %dirLib%lib.cmd "moveFile %dirSystemIn% %dirDiasoftIn% %fileMaskRequestIn% toDiasoft"
rem )
endlocal&exit /b 0


:move_KWTFCB_to_Diasoft
rem ======================================================================
echo  ** ��६�頥� 䠩�� KWTFCB_*.xml �� �� � ������
rem ����⢨� �믮������ ��㣫� ��⪨
rem ======================================================================
setlocal
set      dirSystemIn=c:\work\diasoft\in\
set     dirDiasoftIn=N:\exchange\440p\BRANCHES\0000\IN\
set    fileMaskKWTFCB=KWTFCB_*.xml
where /r %dirSystemIn% /q %fileMaskKWTFCB% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirSystemIn% %dirDiasoftIn% %fileMaskKWTFCB% toDiasoft")
endlocal&exit /b 0


:move_311_to_Diasoft
rem ======================================================================
echo  ** ��६�頥� 䠩�� 311p �� �� � ������
rem ======================================================================
setlocal
set from=c:\work\diasoft\in\
set   to=N:\exchange\311p\FilGo\receive\
set  toPsb=P:\3251\_archiveCrimea\%dateLong%\SB\
set  toPsf=P:\3251\_archiveCrimea\%dateLong%\SF\
set maskSB=SBE??3510123_????????????_24900000??????????_???.xml#SBF??3510123_????????????_24900000??????????_???.xml#SBP??3510123_????????????_24900000??????????_???.xml#SBR??3510123_????????????_24900000??????????_???.xml
set maskSF=SFE??3510123_????????????_24900000??????????_???.xml#SFF??3510123_????????????_24900000??????????_???.xml#SFP??3510123_????????????_24900000??????????_???.xml#SFR??3510123_????????????_24900000??????????_???.xml
where /r %from% /q %maskSB:#= % %maskSF:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
call %dirLib%lib.cmd "copyAndMoveFile %from% %toPsb% %to% %maskSB% toDisk_P toDiasoft"
call %dirLib%lib.cmd "copyAndMoveFile %from% %toPsf% %to% %maskSF% toDisk_P toDiasoft"
rem call %dirLib%lib.cmd "moveFile %from% %to% %mask% toDiasoft"
endlocal&exit /b 0


:move_311_from_Diasoft_to_Temp
rem ======================================================================
echo  ** ��६�頥� 䠩�� 311p �� ������ � ��.TEMP_311
rem ======================================================================
setlocal
set from=P:\3251\OUT\003\
set   to=c:\work\diasoft\TEMP_311\
set mask=SFC??3510123_????????????_24900000??????????_???.xml#SBC??3510123_????????????_24900000??????????_???.xml
where /r %from% /q %mask:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule03dweek% %schedule01time%"
if %checkResult% EQU true (
  call %dirLib%lib.cmd "moveFile %from% %to% %mask% toTemp"
)
endlocal&exit /b 0


:move_311_err_to_Diasoft
rem ======================================================================
echo  ** ��६�頥� 䠩�� 311p �訡��� ���⭮ � ������
rem ======================================================================
setlocal
set from=c:\work\diasoft\TEMP_311\err\
set   to=P:\3251\OUT\003\ERR\
set mask=SFC??3510123_????????????_24900000??????????_???.xml#SBC??3510123_????????????_24900000??????????_???.xml#S?C??3510123_*.err
where /r %from% /q %mask:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
call %dirLib%lib.cmd "moveFile %from% %to% %mask% toErr"
endlocal&exit /b 0


:move_311_from_Diasoft_to_CB
rem ======================================================================
echo  ** ��६�頥� 䠩�� 311p �� ������ � ��
rem ======================================================================
setlocal
set from=c:\work\diasoft\out_311p\
set   to=c:\work\diasoft\out\
set  toPsb=P:\3251\_archiveCrimea\%dateLong%\SB\
set  toPsf=P:\3251\_archiveCrimea\%dateLong%\SF\
set maskSB=SBC??3510123_????????????_24900000??????????_???.xml
set maskSF=SFC??3510123_????????????_24900000??????????_???.xml
where /r %from% /q %maskSB:#= % %maskSF:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
call %dirLib%lib.cmd "copyAndMoveFile %from% %toPsb% %to% %maskSB% toDisk_P toDiasoft"
call %dirLib%lib.cmd "copyAndMoveFile %from% %toPsf% %to% %maskSF% toDisk_P toDiasoft"
rem call %dirLib%lib.cmd "moveFile %from% %to% %mask% fromDiasoft"
endlocal&exit /b 0

