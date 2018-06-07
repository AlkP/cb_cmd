::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem Обработка архивов
rem =========================================

rem Задание переменных
call :setVariable
rem Разархивирование всех архивов
call :extract
rem Перенос разархивированых файлов во входной каталог
call :moveAfterExtract
rem Разархивирование всех архивов содержащие дубли
call :extractRR

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>










































:setVariable
rem ======================================================================
echo  ** Задание переменных
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

set       arjIn=c:\work\from_arj\in\
set      arjOut=c:\work\from_arj\out\

set       dirIn=c:\work\cb_check\ok\
set     dirInRR=c:\work\cb_check\re_receipt\
set  dirArjInRR=c:\work\from_arj_re_receipt\in\
set dirArjOutRR=c:\work\from_arj_re_receipt\out\

exit /b 0

:extract
rem ======================================================================
echo  ** Разархивирование всех архивов
rem + делается копия оригинала архива в bck
rem ======================================================================
where /r %arjIn% /q *.arj > nul
if not errorlevel 1 (call %dirLib%lib.cmd "extractFromArj %arjIn% %arjOut% *.arj")
exit /b 0


:moveAfterExtract
rem ======================================================================
echo  ** Перенос разархивированых файлов во входной каталог
rem ======================================================================
where /r %arjOut% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %arjOut% %dirIn% * moveAfterExtract")
exit /b 0

:extractRR
rem ======================================================================
echo  ** Разархивирование всех архивов содержащие дубли
rem + делается копия оригинала архива в bck
rem ======================================================================
where /r %dirArjInRR% /q *.arj > nul
if not errorlevel 1 (call %dirLib%lib.cmd "extractFromArjRR %dirArjInRR% %dirArjOutRR% %dirIn% %dirInRR% *.arj")
exit /b 0
