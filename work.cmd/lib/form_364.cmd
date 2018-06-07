::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem ��ࠡ�⪠ 䠩��� �� �ଥ 364
rem =========================================

rem ������� ��६�����
call :setVariable
rem ����ࠥ� 䠩�� � ������
call :from_Monitor
rem ��७�ᨬ ESDT_*.arj c ������ ��� �室 RVK
call :from_Monitor_ESDT
rem ��७�ᨬ UVKESDT_*.txt c ������ ��� �室 RVK
call :from_Monitor_UVKESDT

rem ��ࠢ�� DT*.xml 䠩��� �� ����஢��
call :move_DT_to_decrypt
rem ��ࠢ�� RESDT_2490_0000*.txt 䠩��� �� �஢��� ������ 
call :move_RESDT_to_verify
rem ��ࠢ�� DT*.xml 䠩��� �� �஢��� ������ 
call :move_DT_to_verify
rem ��ࠢ�塞 DT*.xml � RVK � � BCK
call :move_DT_to_rvk_and_bck
rem ��ࠢ�塞 DFMVK*.arj � RVK � � BCK
call :move_DFMVK_arj_to_rvk_and_bck
rem ��७�ᨬ RESDT*.txt, ERRDC*.xml � ��娢 � ���뫠�� 㢥��������
call :move_RESDT_to_bck_and_send_report
rem ��ࠢ�� PS_IE3*.xml 䠩��� �� RVK
call :move_PS_IE3_from_rvk_to_system_and_to_bck
rem ��ࠢ�� PS_KR3*.xml 䠩��� �� RVK
call :move_PS_KR3_from_rvk_to_system_and_to_bck
rem ��ࠢ�� PS*.xml 䠩��� �� �������
call :move_PS_to_sign
rem ��ࠢ�� PS*.xml 䠩��� �� ��஢����
call :move_PS_to_encrypt
rem ��ࠢ�塞 PS*.xml �� ��娢���
call :move_PS_to_archive
rem ��ࠢ�塞 PS*.arj �� �������
call :move_PS_archive_to_sign
rem ��७�ᨬ PS*.arj �� �室 ������ ��� ��ࠢ�� � ��
call :to_Monitor

rem ��७�ᨬ NS*.xml, FS*.xml, FC*.xml, ES*.xml, ERRDC*.xml �� �஢��� ������
call :move_NS_FS_ES_to_verify
rem ��७�ᨬ NS*.xml, ES*.xml, FS*.xml, FC*.xml � ��娢 � ���뫠�� 㢥��������
call :move_NS_FS_ES_to_temp_and_send_report
rem ��७�ᨬ NS*.xml, ES*.xml, FS*.xml �� temp � ��娢 � RVK
call :move_NS_FS_ES_from_temp_to_rvk_to_bck


rem ��७�ᨬ FT*.xml �� �������
call :move_FT_to_sign
rem ��७�ᨬ FT*.xml � ������ � RVK
call :move_FT_from_sign_to_RVK
rem ��७�ᨬ KESDT_2490_0000_*.arj � ��
call :move_KESDT_to_CB

rem ��७�ᨬ ARH550P_2490_0000_*.arj �� �室 ������ ��� ��ࠢ�� � ��
rem call :to_Monitor
rem ��ࠢ�� UVARH550P_2490_0000_*.xml 䠩��� � bck
rem call :move_UVARH_to_bck
rem ��������� 㢥�������� UV_2490_0000_CB_ES550P*.xml �� 䠩�� CB_ES550P*.xml
rem call :create_UV
rem ��ࠢ�� ARH550P_2490_0000_*.ARJ 䠩��� �� �����ᠭ��
rem call :move_arj_to_sign
rem ��७�ᨬ ARH550P_2490_0000_*.ARJ 䠩�� �� ��ࠢ��
rem call :send_to_CB

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
echo  ** ��७�ᨬ FNSPS_*.arj c ������ ��� �室
rem ======================================================================
setlocal
set from=t:\fromCB\out\
set to=c:\work\cb\in\
rem set mask=FNSPS*.arj#ESDT_*.arj#24900000*.arj
set mask=FNSPS*.arj#FTSPS*.arj#24900000*.arj
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %to% %dirBck% %mask% toMonitor toBck")
endlocal&exit /b 0

:from_Monitor_ESDT
rem ======================================================================
echo  ** ��७�ᨬ ESDT_*.arj c ������ ��� �室 RVK
rem ======================================================================
setlocal
set from=t:\fromCB\out\
set   to=v:\FROM_FTS\406FZ\ESDT\%dateArch%\
set mask=ESDT_*.arj
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
set subject=����㯨�#䠩�:#$file_name$
set body=��#���ଠ樮����#ᮮ�饭��#�#����祭��#䠩��:#%mask%
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmails %from% %to% %mask% toRVK %emails% %subject% %body%")
endlocal&exit /b 0

:from_Monitor_UVKESDT
rem ======================================================================
echo  ** ��७�ᨬ UVKESDT_*.txt c ������ ��� �室 RVK
rem ======================================================================
setlocal
set from=t:\fromCB\out\
set   to=v:\FROM_FTS\406FZ\UVKESDT\
set mask=UVKESDT_2490_0000_*.txt
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
set subject=����㯨�#䠩�:#$file_name$
set body=����饭��#�#����祭��#䠩��:#%mask%
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %to% %mask% toRVK %emails% %subject% %body%")
endlocal&exit /b 0

:move_DT_to_decrypt
rem ======================================================================
echo  ** ��ࠢ�� DT*.xml 䠩��� �� ����஢��
rem ======================================================================
setlocal
set from=v:\FROM_FTS\406FZ\DT_KA\%dateArch%\
set   to=c:\work\processing\encrypt_decrypt\in\
set mask=DT*.xml
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% moveToDecrypt")
endlocal&exit /b 0

:move_RESDT_to_verify
rem ======================================================================
echo  ** ��ࠢ�� RESDT_2490_0000*.txt 䠩��� �� �஢��� ������ 
rem ======================================================================
setlocal
set from=c:\work\cb_check\ok\
set   to=c:\work\processing\sign_verify\in\
set mask=RESDT_2490_0000*.txt
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% moveToVerify")
endlocal&exit /b 0

:move_DT_to_verify
rem ======================================================================
echo  ** ��ࠢ�� DT*.xml 䠩��� �� �஢��� ������ 
rem ======================================================================
setlocal
set from=c:\work\processing\encrypt_decrypt\out\
set   to=c:\work\processing\sign_verify\in\
set mask=DT*.xml
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% moveToVerify")
endlocal&exit /b 0

:move_DT_to_rvk_and_bck
rem ======================================================================
echo  ** ��ࠢ�塞 DT*.xml � RVK � � BCK
rem ======================================================================
setlocal
set from=c:\work\processing\sign_verify\out\
set   to=v:\FROM_FTS\406FZ\DT\%dateArch%\
set mask=DT*.xml
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %to% %dirBck% %mask% toRVK toBck")
endlocal&exit /b 0

:move_DFMVK_arj_to_rvk_and_bck
rem ======================================================================
echo  ** ��ࠢ�塞 DFMVK*.arj � RVK � � BCK
rem ======================================================================
setlocal
set from=t:\fromCB\out\
set   to=v:\from_cb\DFMVK_VBK\DFMVK\%dateArch%\
set mask=DFMVK*.arj
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %to% %dirBck% %mask% toRVK toBck")
endlocal&exit /b 0

:move_RESDT_to_bck_and_send_report
rem ======================================================================
echo  ** ��७�ᨬ RESDT*.txt, ERRDC*.xml � ��娢 � ���뫠�� 㢥��������
rem ======================================================================
setlocal
set from=c:\work\processing\sign_verify\out\
set mask=RESDT_2490_0000*.txt#ERRDC*.xml
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
set subject=䠩�:#
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %mask% toBck %emails% %subject%")
endlocal&exit /b 0

:move_PS_IE3_from_rvk_to_system_and_to_bck
rem ======================================================================
echo  ** ��ࠢ�� PS*.xml 䠩��� �� RVK IE3
rem ======================================================================
setlocal
set from=v:\TO_FTS\PS_EI\%dateArch%\
set   to=c:\work\diasoft\out\
set  mask=PS*_2490_0000.xml
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %to% %dirArhLong% %mask% fromRVK toBck")
endlocal&exit /b 0

:move_PS_KR3_from_rvk_to_system_and_to_bck
rem ======================================================================
echo  ** ��ࠢ�� PS*.xml 䠩��� �� RVK KR3
rem ======================================================================
setlocal
set from=v:\TO_FNS\PS_KR\%dateArch%\ 
set   to=c:\work\diasoft\out\
set  mask=PS*_2490_0000.xml
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %to% %dirArhLong% %mask% fromRVK toBck")
endlocal&exit /b 0


:move_PS_to_sign
rem ======================================================================
echo  ** ��ࠢ�� PS*.xml 䠩��� �� �������
rem ======================================================================
setlocal
set    dirIn=c:\work\diasoft_check\ok\
set   dirOut=c:\work\processing\sign_sign\in\
set fileMask=PS*_2490_0000.xml
where /r %dirIn% /q %fileMask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirIn% %dirOut% %fileMask% moveToSign")
endlocal&exit /b 0

:move_PS_to_encrypt
rem ======================================================================
echo  ** ��ࠢ�� PS*.xml 䠩��� �� ��஢����
rem ======================================================================
setlocal
set    dirIn=c:\work\processing\sign_sign\out\
set   dirOut=c:\work\processing\encrypt_encrypt\in\
set fileMask=PS*_2490_0000.xml
where /r %dirIn% /q %fileMask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirIn% %dirOut% %fileMask% moveToEncrypt")
endlocal&exit /b 0

:move_PS_to_archive
rem ======================================================================
echo  ** ��ࠢ�塞 PS*.xml �� ��娢���
rem ======================================================================
setlocal
set dirIn=c:\work\processing\encrypt_encrypt\out\
set    dirOut=c:\work\to_arj\in\
set  fileMask=PS*_2490_0000.xml
where /r %dirIn% /q %fileMask% > nul
if errorlevel 1 (endlocal&exit /b 0)
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule01dweek% %schedule01time%"
if %checkResult% EQU true (
  call %dirLib%lib.cmd "moveFile %dirIn% %dirOut% %fileMask% toArchive"
)
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule02dweek% %schedule02time%"
if %checkResult% EQU true (
  call %dirLib%lib.cmd "moveFile %dirIn% %dirOut% %fileMask% toArchive"
)
endlocal&exit /b 0

:move_PS_archive_to_sign
rem ======================================================================
echo  ** ��ࠢ�塞 PS*.arj �� �������
rem ======================================================================
setlocal
set from=c:\work\diasoft_check\ok\
set   to=c:\work\processing\sign_sign\in\
set mask=PS??_2490_0000_*.arj
where /r %from% /q %mask:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
call %dirLib%lib.cmd "moveFile %from% %to% %mask% moveToSign"
endlocal&exit /b 0

:to_Monitor
rem ======================================================================
echo  ** ��७�ᨬ PS*.arj �� �室 ������ ��� ��ࠢ�� � ��
rem ======================================================================
setlocal
set from=c:\work\processing\sign_sign\out\
set to=t:\toCB\in\
set mask=PS??_2490_0000_*.arj
where /r %from% /q %mask:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule01dweek% %schedule01time%"
if %checkResult% EQU true (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toMonitor")
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule02dweek% %schedule02time%"
if %checkResult% EQU true (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toMonitor")

endlocal&exit /b 0

:move_NS_FS_ES_to_verify
rem ======================================================================
echo  ** ��७�ᨬ NS*.xml, FS*.xml, FC*.xml, ES*.xml, ERRDC*.xml �� �஢��� ������
rem ======================================================================
setlocal
set from=c:\work\cb_check\ok\
set to=c:\work\processing\sign_verify\in\
set mask=NS*2490_0000.xml#ES*_2490_0000.xml#FS*_2490_0000.xml#FC*.xml#ERRDC*.xml
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toVerify")
endlocal&exit /b 0

:move_NS_FS_ES_to_temp_and_send_report
rem ======================================================================
echo  ** ��७�ᨬ NS*.xml, ES*.xml, FS*.xml, FC*.xml � ��娢 � ���뫠�� 㢥��������
rem ======================================================================
setlocal
set from=c:\work\processing\sign_verify\out\
set   to=c:\work\temp\
set mask=NS*2490_0000.xml#ES*2490_0000.xml#FS*2490_0000.xml#FC*.xml
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
set subject=����㯨�#䠩�:#$file_name$
set body=�����������#�#����祭��#䠩��
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %to% %mask% toBck %emails% %subject% %body%")
endlocal&exit /b 0

:move_NS_FS_ES_from_temp_to_rvk_to_bck
rem ======================================================================
echo  ** ��७�ᨬ NS*.xml, ES*.xml, FS*.xml �� temp � ��娢 � RVK
rem ======================================================================
setlocal
set from=c:\work\temp\
set   to=v:\364\%dateArch%\
set mask=NS*2490_0000.xml#ES*2490_0000.xml#tz*#FS*2490_0000.xml#FC*.xml
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %to% %dirBck% %mask% toRVK toBck")
endlocal&exit /b 0

:move_FT_to_sign
rem ======================================================================
echo  ** ��७�ᨬ FT*.xml �� �������
rem ======================================================================
setlocal
set from=v:\TO_FTS\406FZ\KVIT\%dateArch%\
set   to=c:\work\processing\sign_sign\in\
set mask=FT*2490_0000_????????????.xml
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %to% %dirBck% %mask% toSign toBck")
endlocal&exit /b 0

:move_FT_from_sign_to_RVK
rem ======================================================================
echo  ** ��७�ᨬ FT*.xml � ������ � RVK
rem ======================================================================
setlocal
set from=c:\work\processing\sign_sign\out\
set   to=v:\TO_FTS\406FZ\KESDT\%dateArch%\
set mask=FT*2490_0000_????????????.xml
where /r %from% /q %mask% > nul
if errorlevel 1 (endlocal&exit /b 0)
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule01dweek% %schedule01time%"
if %checkResult% EQU true (call %dirLib%lib.cmd "moveFile %from% %to% %mask% fromSign")
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule02dweek% %schedule02time%"
if %checkResult% EQU true (call %dirLib%lib.cmd "moveFile %from% %to% %mask% fromSign")

endlocal&exit /b 0

:move_KESDT_to_CB
rem ======================================================================
echo  ** ��७�ᨬ KESDT_2490_0000_*.arj � ��
rem ======================================================================
setlocal
set from=v:\TO_FTS\406FZ\KESDT\%dateArch%\
set   to=t:\toCB\in\
set mask=KESDT_2490_0000_*.arj
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %to% %dirBck% %mask% toCB toBck")
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
