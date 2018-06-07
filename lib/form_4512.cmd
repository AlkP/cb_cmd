::<<<<<<<<<<<<<<<<F<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem Обработка файлов по форме 4512
rem =========================================

rem Задание переменных
call :setVariable

rem Отправка DC*.pdf на подписание
call :move_pdf_fts_to_sign
rem Отправка DC*.pdf для ФНС на подписание
call :move_pdf_fns_to_sign
rem Создание архива из DC*.pdf
call :create_arj_from_pdf
rem Отправка архивов DC*.arj ФТС в валютный
call :send_arj_fts_to_val
rem Отправка архивов DC*.arj ФНС в валютный
call :send_arj_fns_to_val
rem Отправка архивов DC*.arj ФТС из валютного
call :send_arj_fts_from_val
rem Отправка архивов DC*.arj ФНС из валютного
call :send_arj_fns_from_val
rem Отправка архивов DC*.arj в ЦБ
call :send_arj_to_CB

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>






































:setVariable
rem ======================================================================
echo  ** Задание переменных
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"
exit /b 0

:move_pdf_fts_to_sign
rem ======================================================================
echo  ** Отправка DC*.pdf на подписание
rem ======================================================================
setlocal
set from=v:\to_fts\DC_EI\DC\%dateArch%\
set   to=c:\work\processing\sign_sign\in\
set mask=DC*.pdf
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %dirBck% %to% %mask% toBck toSign")
endlocal&exit /b 0
exit /b 0

:move_pdf_fns_to_sign
rem ======================================================================
echo  ** Отправка DC*.pdf на подписание
rem ======================================================================
setlocal
set from=v:\to_fns\DC_KR\DC\%dateArch%\
set   to=c:\work\processing\sign_sign\in\
set mask=DC*.pdf
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %dirBck% %to% %mask% toBck toSign")
endlocal&exit /b 0
exit /b 0

:create_arj_from_pdf
rem ======================================================================
echo  ** Создание архива из DC*.pdf
rem ======================================================================
setlocal
set from=c:\work\processing\sign_sign\out\
set   to=c:\work\processing\encrypt_encrypt\in\
set mask=DC*.pdf
where /r %from% /q %mask:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
set listFiles=%dirLogs%%timeSm%.files
call %dirLib%lib.cmd "getBatchFolder homeFolder"
cd /d %from%
dir /b /ON %mask:#= % > %listFiles%
timeout 3
for /f "tokens=*" %%I in (%listFiles%) do (
  arj.exe A -V5000k -Y -E %to%%%~nI.arj %%I
  del %%I /Q
)
if not "%homeFolder:~0,2%"=="\\" (cd /d %homeFolder%)
del %listFiles%
endlocal&exit /b 0

:send_arj_fts_to_val
rem ======================================================================
echo  ** Отправка архивов DC*.arj ФТС в валютный
rem ======================================================================
setlocal
set from=c:\work\processing\encrypt_encrypt\out\
set   to=v:\to_fts\DC_EI\DC_KA\%dateArch%\
set mask=DC????????_????_????_1_*.a??#DC????????_????_????_2_*.a??#DC????????_????_????_3_*.a??#DC????????_????_????_4_*.a??#DC????????_????_????_9_*.a??
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toVal")
endlocal&exit /b 0

:send_arj_fns_to_val
rem ======================================================================
echo  ** Отправка архивов DC*.arj ФНС в валютный
rem ======================================================================
setlocal
set from=c:\work\processing\encrypt_encrypt\out\
set   to=v:\to_fns\DC_KR\DC_KA\%dateArch%\
set mask=DC????????_????_????_5_*.a??#DC????????_????_????_6_*.a??
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toVal")
endlocal&exit /b 0

:send_arj_fts_from_val
rem ======================================================================
echo  ** Отправка архивов DC*.arj ФТС из валютного
rem ======================================================================
setlocal
set from=v:\to_fts\DC_EI\DC_ARJ\%dateArch%\
set   to=c:\work\processing\sign_sign\in\
set mask=DC??_????_*.a??
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toSign")
endlocal&exit /b 0

:send_arj_fns_from_val
rem ======================================================================
echo  ** Отправка архивов DC*.arj ФНС из валютного
rem ======================================================================
setlocal
set from=v:\to_fns\DC_KR\DC_ARJ\%dateArch%\
set   to=c:\work\processing\sign_sign\in\
set mask=DC??_????_*.a??
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toSign")
endlocal&exit /b 0

:send_arj_to_CB
rem ======================================================================
echo  ** Отправка архивов DC*.arj в ЦБ
rem ======================================================================
setlocal
set from=c:\work\processing\sign_sign\out\
set   to=t:\toCB\in\
set mask=DC??_????_*.a??
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toCB")
endlocal&exit /b 0
