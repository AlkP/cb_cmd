::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem Обработка обновлений 0m
rem =========================================

rem Задание переменных
call :setVariable
rem Перенос файлов 0m с мониторинга на разархивирование
call :fromMonitor
rem Разархивирование главных cab файлов (извлекаем readme и каждое обновление)
call :unCab
rem Отравка readme файлов пользователям ПТКПСД
call :sendReadMe
rem Распаковка обновлений ПТКПСД
call :extractUpdates

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>








































:setVariable
rem ======================================================================
echo  ** Задание переменных
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

exit /b 0

:fromMonitor
rem ======================================================================
echo  ** Перенос файлов 0m с мониторинга на разархивирование
rem ======================================================================
setlocal
set from=t:\fromCB\out\
set to=c:\work\from0m\in\
set mask=0m*010.123

where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% inIncoming")

endlocal&exit /b 0

:unCab
rem ======================================================================
echo  ** Разархивирование главных cab файлов (извлекаем readme и каждое обновление)
rem ======================================================================
setlocal
set from=c:\work\from0m\in\
set to=c:\work\from0m\out\
set cabFiles=0m*010.123
set maskReadMe=*.readme
set maskUpdFiles=0m*.cab

where /r %from% /q %cabFiles% > nul
if errorlevel 1 (endlocal&exit /b 0)

set listFiles=%dirLogs%0m.%timeSm%.files
dir /b /ON %from%%cabFiles% > %listFiles%
for /f "tokens=*" %%I in (%listFiles%) do (
  call %dirLib%lib.cmd "fromCab %from% %to% %%I %maskReadMe%"
  call %dirLib%lib.cmd "fromCab %from% %to% %%I %maskUpdFiles%"
  call %dirLib%lib.cmd "moveFile %from% %dirBck% %%I toBck"
)
del %listFiles%
endlocal&exit /b 0

:sendReadMe
rem ======================================================================
echo  ** Отравка readme файлов пользователям ПТКПСД
rem ======================================================================
setlocal
set from=c:\work\from0m\out\
set maskReadMe=*.readme
set subject=Получено#обновление#ПТКПСД:#
set adminEmails=a.pasenko@crimea.genbank.ru#k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru

where /r %from% /q %maskReadMe% > nul
if errorlevel 1 (endlocal&exit /b 0)
for /f "tokens=*" %%i in ('PSDNotifier.exe email') do set emails=%%i
set listFiles=%dirLogs%0m.%timeSm%.files
dir /b /ON %from%%maskReadMe% > %listFiles%
for /f "tokens=*" %%s in (%listFiles%) do (
  for /f "tokens=*" %%a in (%from%%%s) do (echo ^<p^>%%a^</p^> >> %from%%%s.new)
rem  call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %%s.new toBck %emails% %subject% -html"
  call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %%s.new toBck %adminEmails% %subject% -html"
  del %from%%%s
)
del %listFiles%
endlocal&exit /b 0

:extractUpdates
rem ======================================================================
echo  ** Распаковка обновлений ПТКПСД
rem ======================================================================
setlocal
set from=c:\work\from0m\out\
set to=u:\update\
set mask=0m*.cab

where /r %from% /q %mask% > nul
if errorlevel 1 (endlocal&exit /b 0)
set listFiles=%dirLogs%0m.%timeSm%.files
dir /b /ON %from%%mask% > %listFiles%
for /f "tokens=*" %%s in (%listFiles%) do (
  call %dirLib%lib.cmd "fromCab %from% %to%%%s\ %%s *"
  del %from%%%s
)
del %listFiles%
endlocal&exit /b 0
