::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem Проверка файлов на уникальность, первичная обработка
rem =========================================

rem Задание переменных
call :setVariable
rem Проверка уникальности имени вх файла за день
call :checkIncomingForReReceipt
rem Проверка уникальности имени исх файлов за день
call :checkOutcomingForReReceipt
rem Проверяем, что вх файл уже обработан и возвращаем дубль в работу
call :moveInRR
rem Проверяем, что исх файл уже обработан и возвращаем дубль в работу
call :moveOutRR
rem Сортируем архивы:
call :sortArj

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>






































:setVariable
rem ======================================================================
echo  ** Задание переменных
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

exit /b 0

:checkIncomingForReReceipt
rem ======================================================================
echo  ** Проверка уникальности имени вх файла за день
rem dirIn   - вх каталог
rem dirInOK - каталог для уникальных файлов
rem dirInRR - каталог для дублей файлов
rem ======================================================================
setlocal
set      dirIn=c:\work\cb\in\
set    dirInOK=c:\work\cb_check\ok\
set    dirInRR=c:\work\cb_check\re_receipt\
where /r %dirIn% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "checkUniqueness %dirIn% %dirInOK% %dirInRR% *")
endlocal&exit /b 0

:checkOutcomingForReReceipt
rem ======================================================================
echo  ** Проверка уникальности имени исх файлов за день
rem dirOut   - вх каталог
rem dirOutOK - каталог для уникальных файлов
rem dirOutRR - каталог для дублей файлов
rem ======================================================================
setlocal
set     dirOut=c:\work\diasoft\out\
set   dirOutOK=c:\work\diasoft_check\ok\
set   dirOutRR=c:\work\diasoft_check\re_receipt\
where /r %dirOut% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "checkUniqueness %dirOut% %dirOutOK% %dirOutRR% *")
endlocal&exit /b 0

:moveInRR
rem ======================================================================
echo  ** Проверяем, что вх файл уже обработан и возвращаем дубль в работу
rem ======================================================================
setlocal
set    dirInRR=c:\work\cb_check\re_receipt\
set    dirInOK=c:\work\cb_check\ok\
where /r %dirInRR% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "checkUniquenessRR %dirInRR% %dirInOK%")
endlocal&exit /b 0

:moveOutRR
rem ======================================================================
echo  ** Проверяем, что исх файл уже обработан и возвращаем дубль в работу
rem ======================================================================
setlocal
set   dirOutRR=c:\work\diasoft_check\re_receipt\
set   dirOutOK=c:\work\diasoft_check\ok\
where /r %dirOutRR% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "checkUniquenessRR %dirOutRR% %dirOutOK% inOutgoing")
endlocal&exit /b 0

:sortArj
rem ======================================================================
echo  ** Сортируем архивы:
rem dirInOK - каталог для уникальных файлов
rem dirArjIn   - для архивов в которых нет дублей
rem dirArjInRR - для архивов в которых содержатся файлы которые уже обрабатвались за день
rem ======================================================================
setlocal
set    dirInOK=c:\work\cb_check\ok\
set   dirArjIn=c:\work\from_arj\in\
set dirArjInRR=c:\work\from_arj_re_receipt\in\
set    maskArj=*.arj
where /r %dirInOK% /q %maskArj% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "checkUniquenessArj %dirInOK% %dirArjIn% %dirArjInRR% %maskArj%")
endlocal&exit /b 0
