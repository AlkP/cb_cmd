::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem Обработка файлов по форме 440
rem =========================================

rem Задание переменных
call :setVariable
rem Отправка IZVTUB_AFN_3510123_MIFNS00_*.XML файлов на проверку подписи
call :move_IZV_to_verify
rem Отправка IZVTUB_AFN_3510123_MIFNS00_*.XML файлов в bck
call :move_IZV_to_BCK
rem Отправка KWTFCB_*.TXT файлов на проверку подписи 
call :move_KWTFCB_to_verify
rem Отправка KWTFCB_*.TXT файлов в bck
call :move_KWTFCB_to_Diasoft
rem Отправка ????3510123*.VRB файлов на расшифровку
call :move_Request_to_decrypt
rem Отправка ????3510123*.VRB файлов на проверку подписи 
call :move_Request_to_verify
rem Отправка ????3510123*.VRB файлов в Diasoft
call :move_Request_to_Diasoft
rem Отправка PB?_????3510123_*.xml файлов из Diasoft на подпись
call :move_PB_from_Diasoft_to_sign
rem Отправка PB?_????3510123_*.xml файлов с подписи на архивирование
call :move_PB_from_sign_to_arj
rem Отправка ????_????3510123_*.vrb файлов из Diasoft на подпись
call :move_Answer_from_Diasoft_to_sign
rem Отправка ????_????3510123_*.vrb файлов с подписи на шифрование
call :move_Answer_from_sign_to_encrypt
rem Отправка ????_????3510123_*.vrb файлов с шифрования на архивирование
call :move_Answer_from_encrypt_to_arj
rem Отправка AF?_3510123_MIFNS00_????????_?????.arj на подписание
call :move_arj_Answer_to_sign
rem Отправка AF?_3510123_MIFNS00_????????_?????.arj в ЦБ
call :send_arj_Answer_to_CB

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


















:setVariable
rem ======================================================================
echo  ** Задание переменных
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

rem IN -> OUT
set            dirIn=c:\work\cb_check\ok\
set           dirOut=c:\work\cb\out\

rem others
set     dirDiasoftIn=c:\work\diasoft\in\
set    dirDiasoftOut=c:\work\diasoft_check\ok\

set       dirToArhIn=c:\work\to_arj\in\
set        dirSignIn=c:\work\processing\sign_sign\in\
set       dirSignOut=c:\work\processing\sign_sign\out\
set  dirSignVerifyIn=c:\work\processing\sign_verify\in\
set dirSignVerifyOut=c:\work\processing\sign_verify\out\
set  dirEncryptEncryptIn=c:\work\processing\encrypt_encrypt\in\
set dirEncryptEncryptOut=c:\work\processing\encrypt_encrypt\out\
set  dirEncryptDecryptIn=c:\work\processing\encrypt_decrypt\in\
set dirEncryptDecryptOut=c:\work\processing\encrypt_decrypt\out\

rem MASK
set      fileMaskIZV=IZVTUB_AF?_3510123_MIFNS00_*.XML
set   fileMaskKWTFCB=KWTFCB_*.XML
set  fileMaskRequest=????3510123*.VRB
set       fileMaskPB=PB?_????3510123_*.xml
set   fileMaskAnswer=????_????3510123_*.vrb
set      fileMaskAFN=AF?_3510123_MIFNS00_????????_?????.arj

exit /b 0

:move_IZV_to_verify
rem ======================================================================
echo  ** Отправка IZVTUB_AFN_3510123_MIFNS00_*.XML файлов на проверку подписи
rem ======================================================================
setlocal
set            dirIn=c:\work\cb_check\ok\
set  dirSignVerifyIn=c:\work\processing\sign_verify\in\
set      fileMaskIZV=IZVTUB_AF?_3510123_MIFNS00_*.XML
where /r %dirIn% /q %fileMaskIZV% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirIn% %dirSignVerifyIn% %fileMaskIZV% moveToVerify")
endlocal&exit /b 0


:move_IZV_to_BCK
rem ======================================================================
echo  ** Отправка IZVTUB_AFN_3510123_MIFNS00_*.XML файлов в bck
rem ======================================================================
where /r %dirSignVerifyOut% /q %fileMaskIZV% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirSignVerifyOut% %dirArhLong% %fileMaskIZV% toBck")
rem if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirSignVerifyOut% %dirArhLong% %fileMaskIZV% toBck CreateList %dirArh%%timeSm%.list")
exit /b 0


:move_KWTFCB_to_verify
rem ======================================================================
echo  ** Отправка KWTFCB_*.TXT файлов на проверку подписи 
rem ======================================================================
where /r %dirIn% /q %fileMaskKWTFCB% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirIn% %dirSignVerifyIn% %fileMaskKWTFCB% moveToVerify")
exit /b 0

:move_KWTFCB_to_Diasoft
rem ======================================================================
echo  ** Отправка KWTFCB_*.TXT файлов в bck
rem ======================================================================
where /r %dirSignVerifyOut% /q %fileMaskKWTFCB% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %dirSignVerifyOut% %dirArhLong% %dirDiasoftIn% %fileMaskKWTFCB% toBck PreparationToSend")
rem if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %dirSignVerifyOut% %dirArhLong% %dirDiasoftIn% %fileMaskKWTFCB% toBck toDiasoft CreateList %dirArh%%timeSm%.list")
exit /b 0

:move_Request_to_decrypt
rem ======================================================================
echo  ** Отправка ????3510123*.VRB файлов на расшифровку
rem ======================================================================
where /r %dirIn% /q %fileMaskRequest% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirIn% %dirEncryptDecryptIn% %fileMaskRequest% moveToDecrypt")
exit /b 0

:move_Request_to_verify
rem ======================================================================
echo  ** Отправка ????3510123*.VRB файлов на проверку подписи 
rem ======================================================================
where /r %dirEncryptDecryptOut% /q %fileMaskRequest% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirEncryptDecryptOut% %dirSignVerifyIn% %fileMaskRequest% moveToVerify")
exit /b 0

:move_Request_to_Diasoft
rem ======================================================================
echo  ** Отправка ????3510123*.VRB файлов в Diasoft
rem ======================================================================
where /r %dirSignVerifyOut% /q %fileMaskRequest% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %dirSignVerifyOut% %dirArhLong% %dirDiasoftIn% %fileMaskRequest% toBck PreparationToSend")
rem if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %dirSignVerifyOut% %dirArhLong% %dirDiasoftIn% %fileMaskRequest% toBck toDiasoft CreateList %dirArh%%timeSm%.list")
exit /b 0

:move_PB_from_Diasoft_to_sign
rem ======================================================================
echo  ** Отправка PB?_????3510123_*.xml файлов из Diasoft на подпись
rem ======================================================================
where /r %dirDiasoftOut% /q %fileMaskPB% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %dirDiasoftOut% %dirArhLong% %dirSignIn% %fileMaskPB% toBck toSign")
rem if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %dirDiasoftOut% %dirArhLong% %dirSignIn% %fileMaskPB% toBck toSign CreateList %dirArh%%timeSm%.list")
exit /b 0

:move_PB_from_sign_to_arj
rem ======================================================================
echo  ** Отправка PB?_????3510123_*.xml файлов с подписи на архивирование
rem ======================================================================
where /r %dirSignOut% /q %fileMaskPB% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirSignOut% %dirToArhIn% %fileMaskPB% toArchiveDir")
exit /b 0

:move_Answer_from_Diasoft_to_sign
rem ======================================================================
echo  ** Отправка ????_????3510123_*.vrb файлов из Diasoft на подпись
rem ======================================================================
where /r %dirDiasoftOut% /q %fileMaskAnswer% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %dirDiasoftOut% %dirArhLong% %dirSignIn% %fileMaskAnswer% toBck toSign")
rem if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %dirDiasoftOut% %dirArhLong% %dirSignIn% %fileMaskAnswer% toBck toSign CreateList %dirArh%%timeSm%.list")
exit /b 0

:move_Answer_from_sign_to_encrypt
rem ======================================================================
echo  ** Отправка ????_????3510123_*.vrb файлов с подписи на шифрование
rem ======================================================================
where /r %dirSignOut% /q %fileMaskAnswer% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirSignOut% %dirEncryptEncryptIn% %fileMaskAnswer% toEncrypt")
exit /b 0

:move_Answer_from_encrypt_to_arj
rem ======================================================================
echo  ** Отправка ????_????3510123_*.vrb файлов с шифрования на архивирование
rem ======================================================================
where /r %dirEncryptEncryptOut% /q %fileMaskAnswer% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %dirEncryptEncryptOut% %dirToArhIn% %fileMaskAnswer% toArchiveDir")
exit /b 0

:move_arj_Answer_to_sign
rem ======================================================================
echo  ** Отправка AF?_3510123_MIFNS00_????????_?????.arj на подписание
rem ======================================================================
where /r %dirDiasoftOut% /q %fileMaskAFN% > nul
if errorlevel 1 (exit /b 0)
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON %dirDiasoftOut%%fileMaskAFN% > %listFiles%
timeout 3
for /f "tokens=*" %%I in (%listFiles%) do (
  call %dirLib%lib.cmd "setTime"
  call %dirLib%lib.cmd "saveListArh %dirDiasoftOut%%%I %dirLogs%%%I.%timeSn%.list"
  call %dirLib%lib.cmd "moveDouble %dirDiasoftOut% %dirSignIn% %%I"
  call %dirLib%lib.cmd "writeLog %%I toSign %dirDiasoftOut% %dirSignIn%"
)
del %listFiles%
exit /b 0

:send_arj_Answer_to_CB
rem ======================================================================
echo  ** Отправка AF?_3510123_MIFNS00_????????_?????.arj в ЦБ
rem ======================================================================
where /r %dirSignOut% /q %fileMaskAFN% > nul
if errorlevel 1 (exit /b 0)
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule01dweek% %schedule03time%"
if %checkResult% EQU true (
  call %dirLib%lib.cmd "moveFile %dirSignOut% %dirOut% %fileMaskAFN% toCB"
)
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule02dweek% %schedule04time%"
if %checkResult% EQU true (
  call %dirLib%lib.cmd "moveFile %dirSignOut% %dirOut% %fileMaskAFN% toCB"
)
exit /b 0

