::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem Обработка файлов по форме 364
rem =========================================

rem Задание переменных
call :setVariable
rem Забираем файлы с монитора
call :from_Monitor
rem Переносим ESDT_*.arj c монитора для вход RVK
call :from_Monitor_ESDT
rem Переносим UVKESDT_*.txt c монитора для вход RVK
call :from_Monitor_UVKESDT

rem Отправка DT*.xml файлов на расшифровку
call :move_DT_to_decrypt
rem Отправка RESDT_2490_0000*.txt файлов на проверку подписи 
call :move_RESDT_to_verify
rem Отправка DT*.xml файлов на проверку подписи 
call :move_DT_to_verify
rem Отправляем DT*.xml в RVK и в BCK
call :move_DT_to_rvk_and_bck
rem Отправляем DFMVK*.arj в RVK и в BCK
call :move_DFMVK_arj_to_rvk_and_bck
rem Переносим RESDT*.txt, ERRDC*.xml в архив и рассылаем уведомление
call :move_RESDT_to_bck_and_send_report
rem Отправка PS_IE3*.xml файлов из RVK
call :move_PS_IE3_from_rvk_to_system_and_to_bck
rem Отправка PS_KR3*.xml файлов из RVK
call :move_PS_KR3_from_rvk_to_system_and_to_bck
rem Отправка PS*.xml файлов на подпись
call :move_PS_to_sign
rem Отправка PS*.xml файлов на шифрование
call :move_PS_to_encrypt
rem Отправляем PS*.xml на архивацию
call :move_PS_to_archive
rem Отправляем PS*.arj на подпись
call :move_PS_archive_to_sign
rem Переносим PS*.arj на вход монитора для отправки в ЦБ
call :to_Monitor

rem Переносим NS*.xml, FS*.xml, FC*.xml, ES*.xml, ERRDC*.xml на проверку подписи
call :move_NS_FS_ES_to_verify
rem Переносим NS*.xml, ES*.xml, FS*.xml, FC*.xml в архив и рассылаем уведомление
call :move_NS_FS_ES_to_temp_and_send_report
rem Переносим NS*.xml, ES*.xml, FS*.xml из temp в архив и RVK
call :move_NS_FS_ES_from_temp_to_rvk_to_bck


rem Переносим FT*.xml на подпись
call :move_FT_to_sign
rem Переносим FT*.xml с подписи в RVK
call :move_FT_from_sign_to_RVK
rem Переносим KESDT_2490_0000_*.arj в ЦБ
call :move_KESDT_to_CB

rem Переносим ARH550P_2490_0000_*.arj на вход монитора для отправки в ЦБ
rem call :to_Monitor
rem Отправка UVARH550P_2490_0000_*.xml файлов в bck
rem call :move_UVARH_to_bck
rem Созадание уведомлений UV_2490_0000_CB_ES550P*.xml на файлы CB_ES550P*.xml
rem call :create_UV
rem Отправка ARH550P_2490_0000_*.ARJ файлов на подписание
rem call :move_arj_to_sign
rem Переносим ARH550P_2490_0000_*.ARJ файлы на отправку
rem call :send_to_CB

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
































:setVariable
rem ======================================================================
echo  ** Задание переменных
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"
exit /b 0

:from_Monitor
rem ======================================================================
echo  ** Переносим FNSPS_*.arj c монитора для вход
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
echo  ** Переносим ESDT_*.arj c монитора для вход RVK
rem ======================================================================
setlocal
set from=t:\fromCB\out\
set   to=v:\FROM_FTS\406FZ\ESDT\%dateArch%\
set mask=ESDT_*.arj
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
set subject=Поступил#файл:#$file_name$
set body=Это#информационное#сообщение#о#получении#файла:#%mask%
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmails %from% %to% %mask% toRVK %emails% %subject% %body%")
endlocal&exit /b 0

:from_Monitor_UVKESDT
rem ======================================================================
echo  ** Переносим UVKESDT_*.txt c монитора для вход RVK
rem ======================================================================
setlocal
set from=t:\fromCB\out\
set   to=v:\FROM_FTS\406FZ\UVKESDT\
set mask=UVKESDT_2490_0000_*.txt
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
set subject=Поступил#файл:#$file_name$
set body=Сообщение#о#получении#файла:#%mask%
where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %to% %mask% toRVK %emails% %subject% %body%")
endlocal&exit /b 0

:move_DT_to_decrypt
rem ======================================================================
echo  ** Отправка DT*.xml файлов на расшифровку
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
echo  ** Отправка RESDT_2490_0000*.txt файлов на проверку подписи 
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
echo  ** Отправка DT*.xml файлов на проверку подписи 
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
echo  ** Отправляем DT*.xml в RVK и в BCK
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
echo  ** Отправляем DFMVK*.arj в RVK и в BCK
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
echo  ** Переносим RESDT*.txt, ERRDC*.xml в архив и рассылаем уведомление
rem ======================================================================
setlocal
set from=c:\work\processing\sign_verify\out\
set mask=RESDT_2490_0000*.txt#ERRDC*.xml
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
set subject=файл:#
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %mask% toBck %emails% %subject%")
endlocal&exit /b 0

:move_PS_IE3_from_rvk_to_system_and_to_bck
rem ======================================================================
echo  ** Отправка PS*.xml файлов из RVK IE3
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
echo  ** Отправка PS*.xml файлов из RVK KR3
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
echo  ** Отправка PS*.xml файлов на подпись
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
echo  ** Отправка PS*.xml файлов на шифрование
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
echo  ** Отправляем PS*.xml на архивацию
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
echo  ** Отправляем PS*.arj на подпись
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
echo  ** Переносим PS*.arj на вход монитора для отправки в ЦБ
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
echo  ** Переносим NS*.xml, FS*.xml, FC*.xml, ES*.xml, ERRDC*.xml на проверку подписи
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
echo  ** Переносим NS*.xml, ES*.xml, FS*.xml, FC*.xml в архив и рассылаем уведомление
rem ======================================================================
setlocal
set from=c:\work\processing\sign_verify\out\
set   to=c:\work\temp\
set mask=NS*2490_0000.xml#ES*2490_0000.xml#FS*2490_0000.xml#FC*.xml
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
set subject=Поступил#файл:#$file_name$
set body=Уведомление#о#получении#файла
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %to% %mask% toBck %emails% %subject% %body%")
endlocal&exit /b 0

:move_NS_FS_ES_from_temp_to_rvk_to_bck
rem ======================================================================
echo  ** Переносим NS*.xml, ES*.xml, FS*.xml из temp в архив и RVK
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
echo  ** Переносим FT*.xml на подпись
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
echo  ** Переносим FT*.xml с подписи в RVK
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
echo  ** Переносим KESDT_2490_0000_*.arj в ЦБ
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
echo  ** Отправка UVARH550P_2490_0000_*.xml файлов в bck
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
echo  ** Созадание уведомлений UV_2490_0000_CB_ES550P*.xml на файлы CB_ES550P*.xml
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
echo  ** Отправляем UV_2490_0000_CB_ES550P*.xml на архивацию
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
echo  ** Отправка ARH550P_2490_0000_*.ARJ файлов на подписание
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
echo  ** Переносим ARH550P_2490_0000_*.ARJ файлы на отправку
rem ======================================================================
setlocal
set  dirSignOut=c:\work\processing\sign_sign\out\
set        toCB=c:\work\cb\out\
set fileArjMask=ARH550P_2490_0000_*.arj
where /r %dirSignOut% /q %fileArjMask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirSignOut% %toCB% %fileArjMask% sendToCB")
endlocal&exit /b 0
