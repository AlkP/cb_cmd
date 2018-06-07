::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem Обработка пакетов ЦБ
rem =========================================

rem Задание переменных
call :setVariable
rem Получение mz*10.123 из ЦБ
rem call :move_mz_files_from_CB
rem Забираем файлы с монитора
call :from_Monitor
rem Переносим AF?_3510123_MIFNS00_*.ARJ на вход монитора для отправки в ЦБ
call :to_Monitor

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>











































:setVariable
rem ======================================================================
echo  ** Задание переменных
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"
exit /b 0

:move_mz_files_from_CB
rem ======================================================================
echo  ** Получение mz*10.123 из ЦБ
rem ======================================================================
setlocal
set from=r:\inc\ptk_psd\
set to=t:\fromCB\in\
set maskFiles=mz*10.123
where /r %from% /q %maskFiles:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
call %dirLib%lib.cmd "checkSchedule %dateL:~0,10% %timeL:~0,5% %schedule03dweek% %schedule05time%"
if %checkResult% EQU true (
  call %dirLib%lib.cmd "moveFile %from% %to% %maskFiles% inIncoming"
)
endlocal&exit /b 0

:from_Monitor
rem ======================================================================
echo  ** Забираем файлы с монитора
rem ======================================================================
setlocal
set from=t:\fromCB\out\
set to=c:\work\cb\in\
rem set to55=s:\in\
set mask=AF?_MIFNS00_3510123_*.ARJ#IZVTUB_AF?_3510123_MIFNS00_*.XML
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toSystem")
rem if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %to55% %to% %mask% toARMCB toSystem")
endlocal&exit /b 0

:to_Monitor
rem ======================================================================
echo  ** Переносим AF?_3510123_MIFNS00_*.ARJ на вход монитора для отправки в ЦБ
rem ======================================================================
setlocal
set from=c:\work\cb\out\
set to=t:\toCB\in\
set mask=AF?_3510123_MIFNS00_*.ARJ
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toMonitor")
endlocal&exit /b 0
