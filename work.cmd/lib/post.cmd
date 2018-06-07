::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem Обработка вх корреспонденции
rem =========================================

rem Задание переменных
call :setVariable
rem Переносим pdf файлы на локальный диск
call :pdfIn
rem Переносим pdf в архив почты и отправляем уведомление по email
call :pdfToArhAndSendEmail
rem Переносим ОД*.rar файлы на локальный диск
call :odIn
rem Переносим 1234.rar файлы на локальный диск
call :numeralRarIn
rem Разархивируем *.rar в архив вх сообщений и отправляем письмо с ссылкой
call :extractFromRarAndSend

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>






































:setVariable
rem ======================================================================
echo  ** Задание переменных
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

exit /b 0

:pdfIn
rem ======================================================================
echo  ** Переносим pdf файлы на локальный диск
rem ======================================================================
setlocal
set from=r:\inc\
set to=c:\work\pdf\
set mask=*.pdf

where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toLocal")

endlocal&exit /b 0

:pdfToArhAndSendEmail
rem ======================================================================
echo  ** Переносим pdf в архив почты и отправляем уведомление по email
rem ======================================================================
setlocal
set from=c:\work\pdf\
set to=ПутьКПапке\Переписка#с#ЦБ\Крым#ЦБ\%date:~6,4%\%date:~6,4%%date:~3,2%\%date:~6,4%%date:~3,2%%date:~0,2%\
set mask=*.pdf
rem set emails=CRFilPriemnayaBucenko@crimea.genbank.ru#CRSecDel@crimea.genbank.ru#ludogovskaya@genbank.ru#priemnaya@genbank.ru#cb24@crimea.genbank.ru#va17@genbank.ru#s.navoenok@genbank.ru#popov@genbank.ru#p.saveliev@genbank.ru
set emails=CRFilPriemnayaBucenko@crimea.genbank.ru#CRSecDel@crimea.genbank.ru#priemnaya@genbank.ru
rem set emails=a.pasenko@crimea.genbank.ru
set subject=Поступила#почта:#$file_name$
rem как задать спец символы
rem = = $1$    < = $2$    > = $3$
rem П Р И М Е Р : <p>Письмо доступно по <a href='%reportsTo:#= %%fileName%'>ссылке</a></p>
rem             $2$p$3$Письмо#доступно#по#$2$a#href$1$'%to%$file_name$'$3$ссылке$2$/a$3$$2$/p$3$
set body=$2$p$3$Письмо#доступно#по#$2$a#href$1$'%to%$file_name$'$3$ссылке$2$/a$3$$2$/p$3$

where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmails %from% %to% %mask% toArh %emails% %subject% %body%")

endlocal&exit /b 0

:odIn
rem ======================================================================
echo  ** Переносим ОД*.rar файлы на локальный диск
rem ======================================================================
setlocal
set from=r:\inc\
set to=c:\work\fromRar\in\
set mask=ОД*.rar

where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toLocal")

endlocal&exit /b 0

:numeralRarIn
rem ======================================================================
echo  ** Переносим 1234.rar файлы на локальный диск
rem ======================================================================
setlocal
set from=r:\inc\
set to=c:\work\fromRar\in\
call %dirLib%lib.cmd "setTime"
set tmp=%dirLogs%rar.%timeSn%.list
call %dirLib%lib.cmd "getBatchFolder homeFolder"
cd /d %from%

where /r %from% /q ????.rar ?????.rar > nul
if not errorlevel 1 (
  dir /b /ON | findstr /R "^[0-9]*[.]rar$" > %tmp%
  for /f "tokens=*" %%I in (%tmp%) do (
    move "%from%%%I" "%to%"
    call :writeLog %%I inIncoming %from% %to%
  )
  del /Q %tmp%
)
if not "%homeFolder:~0,2%"=="\\" (cd /d %homeFolder%)
endlocal&exit /b 0

:extractFromRarAndSend
rem ======================================================================
echo  ** Разархивируем *.rar в архив вх сообщений и отправляем письмо с ссылкой
rem ======================================================================
setlocal
set from=c:\work\fromRar\in\
set to=ПутьКПапке\Переписка#с#ЦБ\Крым#ЦБ\%date:~6,4%\%date:~6,4%%date:~3,2%\%date:~6,4%%date:~3,2%%date:~0,2%\
set mask=*.rar
rem set emails=CRFilPriemnayaBucenko@crimea.genbank.ru#CRSecDel@crimea.genbank.ru#ludogovskaya@genbank.ru#priemnaya@genbank.ru#cb24@crimea.genbank.ru#va17@genbank.ru#k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru#s.navoenok@genbank.ru#popov@genbank.ru#p.saveliev@genbank.ru
set emails=CRFilPriemnayaBucenko@crimea.genbank.ru#CRSecDel@crimea.genbank.ru#priemnaya@genbank.ru#k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru
set subject=Поступила#почта:#$file_name$
set body=$2$p$3$Письмо#доступно#по#$2$a#href$1$'%to%$file_name$'$3$ссылке$2$/a$3$$2$/p$3$

where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "extractFromRarAndSend %from% %to% %mask% %emails% %subject% %body%")

endlocal&exit /b 0



