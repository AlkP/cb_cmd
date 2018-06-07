::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem ��ࠡ�⪠ 䠩��� �� �ଥ 550
rem =========================================

rem ������� ��६�����
call :setVariable
rem ����ࠥ� 䠩�� � ������ � ��ࠢ��� 㢥��������
call :from_Monitor
rem ��७�ᨬ ARH550P_2490_0000_*.arj �� �室 ������ ��� ��ࠢ�� � ��
call :to_Monitor
rem ��ࠢ�� UVARH550P_2490_0000_*.xml 䠩��� � bck
call :move_UVARH_to_bck
rem ��ࠢ�� CB_ES550P*.xml 䠩��� �� ����஢��
call :move_to_decrypt
rem ��ࠢ�� CB_ES550P*.xml 䠩��� �� �஢��� ������ 
call :move_to_verify
rem ��������� 㢥�������� UV_2490_0000_CB_ES550P*.xml �� 䠩�� CB_ES550P*.xml
call :create_UV
rem ��ࠢ�塞 UV_2490_0000_CB_ES550P*.xml �� ��娢���
call :move_to_archive_and_bck
rem ��ࠢ�� ARH550P_2490_0000_*.ARJ 䠩��� �� �����ᠭ��
call :move_arj_to_sign
rem ��७�ᨬ ARH550P_2490_0000_*.ARJ 䠩�� �� ��ࠢ��
call :send_to_CB

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
































:setVariable
rem ======================================================================
echo  ** ������� ��६�����
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

exit /b 0

:from_Monitor
rem ======================================================================
echo  ** ����ࠥ� 䠩�� � ������ � ��ࠢ��� 㢥��������
rem ======================================================================
setlocal
set from=t:\fromCB\out\
set to=c:\work\cb\in\

set mask=UVARH550P*.xml
set emails=k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru
set subject=����㯨�#䠩�:#$file_name$
set body=����㯨��#㢥��������#�#����祭��#䠩��##%mask%

where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %to% %mask% toSystem %emails% %subject% %body%")

set mask=cb_550p_*.arj
set emails=k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru
set subject=����㯨�#䠩�:#$file_name$
set body=��#���ଠ樮����#ᮮ�饭��#�#����祭��#䠩��#%mask%

where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmails %from% %to% %mask% toSystem %emails% %subject% %body%")

set maskFiles=wz*
set emails=k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %maskFiles% toBck %emails% 䠩�:#")
endlocal&exit /b 0

:to_Monitor
rem ======================================================================
echo  ** ��७�ᨬ ARH550P_2490_0000_*.arj �� �室 ������ ��� ��ࠢ�� � ��
rem ======================================================================
setlocal
set from=c:\work\cb\out\
set to=t:\toCB\in\
set mask=ARH550P_2490_0000_*.arj
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toMonitor")
endlocal&exit /b 0

:move_UVARH_to_bck
rem ======================================================================
echo  ** ��ࠢ�� UVARH550P_2490_0000_*.xml 䠩��� � bck
rem ======================================================================
setlocal
set      dirInCheck=c:\work\cb_check\ok\
set fileMaskUVARH=UVARH550P_2490_0000_*.xml
where /r %dirInCheck% /q %fileMaskUVARH% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirInCheck% %dirArhLong% %fileMaskUVARH% toBCK")
rem if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirInCheck% %dirArhLong% %fileMaskUVARH% toBCK CreateList %dirArh%%timeSm%.list")
endlocal&exit /b 0

:move_to_decrypt
rem ======================================================================
echo  ** ��ࠢ�� CB_ES550P*.xml 䠩��� �� ����஢��
rem ======================================================================
setlocal
set   dirInCheck=c:\work\cb_check\ok\
set dirDecryptIn=c:\work\processing\550_decrypt\in\
set     fileMask=CB_ES550P*.xml
where /r %dirInCheck% /q %fileMask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirInCheck% %dirDecryptIn% %fileMask% moveToDecrypt")
endlocal&exit /b 0

:move_to_verify
rem ======================================================================
echo  ** ��ࠢ�� CB_ES550P*.xml 䠩��� �� �஢��� ������ 
rem ======================================================================
setlocal
set dirDecryptOut=c:\work\processing\550_decrypt\out\
set   dirVerifyIn=c:\work\processing\550_verify\in\
set      fileMask=CB_ES550P*.xml
where /r %dirDecryptOut% /q %fileMask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirDecryptOut% %dirVerifyIn% %fileMask% moveToVerify")
endlocal&exit /b 0

:create_UV
rem ======================================================================
echo  ** ��������� 㢥�������� UV_2490_0000_CB_ES550P*.xml �� 䠩�� CB_ES550P*.xml
rem ======================================================================
setlocal
set  dirVerifyOut=c:\work\processing\550_verify\out\
set dirDiasoftOut=c:\work\diasoft\out\
set      fileMask=CB_ES550P*.xml
where /r %dirVerifyOut% /q %fileMask% > nul
if not errorlevel 1 (
  call %dirLib%lib.cmd "createUVfilesAndMoveToBck %dirVerifyOut% %dirDiasoftOut% %dirArhLong% %fileMask%"
  rem call %dirLib%lib.cmd "moveFile %dirVerifyOut% %dirArhLong% %fileMask% toBCK CreateList %dirArh%%timeSm%.list"
)
endlocal&exit /b 0

:move_to_archive_and_bck
rem ======================================================================
echo  ** ��ࠢ�塞 UV_2490_0000_CB_ES550P*.xml �� ��娢���
rem ======================================================================
setlocal
set dirOutCheck=c:\work\diasoft_check\ok\
set    dirToArh=c:\work\to_arj\in\
set  fileMaskUV=UV_2490_0000_CB_ES550P*.xml
where /r %dirOutCheck% /q %fileMaskUV% > nul
if errorlevel 1 (endlocal&exit /b 0)
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule01dweek% %schedule01time%"
if %checkResult% EQU true (
  call %dirLib%lib.cmd "copyAndMoveFile %dirOutCheck% %dirToArh% %dirArhLong% %fileMaskUV% toArchive toBck"
)
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule02dweek% %schedule02time%"
if %checkResult% EQU true (
  call %dirLib%lib.cmd "copyAndMoveFile %dirOutCheck% %dirToArh% %dirArhLong% %fileMaskUV% toArchive toBck"
)
endlocal&exit /b 0


:move_arj_to_sign
rem ======================================================================
echo  ** ��ࠢ�� ARH550P_2490_0000_*.ARJ 䠩��� �� �����ᠭ��
rem ======================================================================
setlocal
set dirOutCheck=c:\work\diasoft_check\ok\
set   dirSignIn=c:\work\processing\sign_sign\in\
set fileArjMask=ARH550P_2490_0000_*.arj
where /r %dirOutCheck% /q %fileArjMask% > nul
if errorlevel 1 (endlocal&exit /b 0)
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON %dirOutCheck%%fileArjMask% > %listFiles%
timeout 3
for /f "tokens=*" %%I in (%listFiles%) do (
  call %dirLib%lib.cmd "setTime"
  call %dirLib%lib.cmd "saveListArh %dirOutCheck%%%I %dirLogs%%%I.%timeSn%.list"
  call %dirLib%lib.cmd "moveDouble %dirOutCheck% %dirSignIn% %%I"
  call %dirLib%lib.cmd "writeLog %%I toSign %dirOutCheck% %dirSignIn%"
)
del %listFiles%
endlocal&exit /b 0

:send_to_CB
rem ======================================================================
echo  ** ��७�ᨬ ARH550P_2490_0000_*.ARJ 䠩�� �� ��ࠢ��
rem ======================================================================
setlocal
set  dirSignOut=c:\work\processing\sign_sign\out\
set        toCB=c:\work\cb\out\
set fileArjMask=ARH550P_2490_0000_*.arj
where /r %dirSignOut% /q %fileArjMask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirSignOut% %toCB% %fileArjMask% sendToCB")
endlocal&exit /b 0
