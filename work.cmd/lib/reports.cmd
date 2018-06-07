::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem Обработка отчетов
rem =========================================

rem Задание переменных
call :setVariable
rem Перенос файлов .xml.cab с мониторинга на разархивирование
call :fromMonitor
rem Разархивирование xml файлов
call :unCab
rem Рассылка отчетов пользователям на email
call :send_incoming_report_to_users_and_move_to_arh
rem Рассылка xml отчетов пользователям на email
call :send_xml_incoming_report_to_users_and_move_to_arh
rem Рассылка уведомлений пользователям на email
rem call :send_incoming_attentions_to_users_and_move_to_arh

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
echo  ** Перенос файлов .xml.cab с мониторинга на разархивирование
rem ======================================================================
setlocal
set from=t:\fromCB\out\
set to=c:\work\fromCab\in\
set mask=*.xml.cab

where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% inIncoming")

endlocal&exit /b 0

:unCab
rem ======================================================================
echo  ** Разархивирование xml файлов
rem ======================================================================
setlocal
set from=c:\work\fromCab\in\
set to=c:\work\fromCab\out\
set cabFiles=*.xml.cab
set maskXml=*.123.xml

where /r %from% /q %cabFiles% > nul
if errorlevel 1 (endlocal&exit /b 0)

set listFiles=%dirLogs%xml.cab.%timeSm%.files
dir /b /ON %from%%cabFiles% > %listFiles%
for /f "tokens=*" %%I in (%listFiles%) do (
  call %dirLib%lib.cmd "fromCab %from% %to% %%I %maskXml%"
  call %dirLib%lib.cmd "moveFile %from% %dirBck% %%I toBck"
)
)
del %listFiles%
endlocal&exit /b 0

:send_incoming_report_to_users_and_move_to_arh
rem ======================================================================
echo  ** Рассылка отчетов пользователям на email
rem ======================================================================
setlocal
set maskFiles=0q*#2p*#2q*#2m*#2z*#4e*#6t*#7v*#pl*#pk*#r3*#mz*#nl*#r9*#UVZ10123*.xml#5b*#*.doc#*.docx#tz*#*123GEBA#UVPS*.xml#UVDC*.xml#UVARHOS*.xml#UVOS*.xml
set from=t:\fromCB\out\
set temp=c:\work\temp\
where /r %from% /q %maskFiles:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
set subject=файл:#

set maskFiles=0q*10.123#2p*10.123#2q*10.123#2m*10.123#4e*10.123#7v*10.123#pl*10.123#pk*10.123#r3*10.123
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %maskFiles% toBck %emails% %subject%")

set maskFiles=nl*10.123
set emails=umerenkova@crimea.genbank.ru#voroneckaya@crimea.genbank.ru
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %maskFiles% toBck %emails% %subject%")

set maskFiles=tz*10.123
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru#t.slisenko@crimea.genbank.ru
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %temp% %maskFiles% toBck %emails% %subject%")

set maskFiles=r9*10.123
set emails=z.duniamalyan@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru#nataliya.volkova@genbank.ru#l.zaharova@genbank.ru
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %maskFiles% toBck %emails% %subject%")

set maskFiles=mz????10.123
set emails=k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %maskFiles% toBck %emails% %subject%")

set maskFiles=2z????10.123
set emails=k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %maskFiles% toBck %emails% %subject%")

set maskFiles=6t????10.123
set emails=kudrina@genbank.ru#zhuravlev@genbank.ru
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %maskFiles% toBck %emails% %subject%")

set maskFiles=UVZ10123*.xml#UVOS*.xml
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru#t.slisenko@crimea.genbank.ru
set body=Поступило#информационный#файл##%maskFiles%
set subject=Поступил#файл:#$file_name$
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %dirBck% %maskFiles% toBck %emails% %subject% %body%")

set maskFiles=*.doc#*.docx
set emails=k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru
set subject=Поступил#файл:#$file_name$
set body=Поступило#информационный#файл##%maskFiles%
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %dirBck% %maskFiles% toBck %emails% %subject% %body%")

set tbsvk=v:\364\%dateArch%
set maskFiles=112*.xml
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru#t.slisenko@crimea.genbank.ru
set subject=Поступил#файл:#$file_name$
set body=Поступило#информационный#файл##%maskFiles%
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %dirBck% %maskFiles% toBck %emails% %subject% %body%")

set tbsvk=v:\364\%dateArch%
set maskFiles=UVPS*.xml#UVDC*.xml#UVARHOS*.xml
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru#t.slisenko@crimea.genbank.ru
set subject=Поступил#файл:#$file_name$
set body=Поступило#информационный#файл##%maskFiles%
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %from% %dirBck% %temp% %maskFiles% toBck toTemp")
where /r %temp% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %temp% %tbsvk% %maskFiles% toTBSVK %emails% %subject% %body%")

set maskFiles=5b*.xml
rem set emails=k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru#zhilyaeva@genbank.ru#popov@genbank.ru#s.navoenok@genbank.ru#p.saveliev@genbank.ru
set emails=k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru#zhilyaeva@genbank.ru
set subject=Поступил#файл:#$file_name$
set body=Поступило#уведомление#о#получении#файла##%maskFiles%
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %dirBck% %maskFiles% toBck %emails% %subject% %body%")

set maskFiles=5b*10.123
rem set emails=k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru#zhilyaeva@genbank.ru#popov@genbank.ru#s.navoenok@genbank.ru#p.saveliev@genbank.ru
set emails=k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru#zhilyaeva@genbank.ru
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %maskFiles% toBck %emails% %subject%")

endlocal&exit /b 0

:send_xml_incoming_report_to_users_and_move_to_arh
rem ======================================================================
echo  ** Рассылка xml отчетов пользователям на email
rem ======================================================================
setlocal
set mask=*.xml
set from=c:\work\fromCab\out\
where /r %from% /q %mask:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
set subject=файл:#

set mask=3e*.123.xml
set emails=zuek@genbank.ru#e.sadovskaya@genbank.ru
set subject=файл:#%mask%
set body=Поступило#уведомление#о#получении#файла##%mask%
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %dirBck% %mask% toBck %emails% %subject% %body%")

set mask=pk*.123.xml#pl*.123.xml
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendEmails %from% %dirBck% %mask% toBck %emails% %subject%")

set mask=0q*.123.xml#7v*.123.xml#sp*.123.xml
set emails=i.savchenko@crimea.genbank.ru#s.gatsulenko@crimea.genbank.ru#a.makaryin@crimea.genbank.ru
set subject=файл:#%mask%
set body=Поступило#уведомление#о#получении#файла##%mask%
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %dirBck% %mask% toBck %emails% %subject% %body%")

set mask=6t*.123.xml
set emails=kudrina@genbank.ru#zhuravlev@genbank.ru
set subject=файл:#%mask%
set body=Поступило#уведомление#о#получении#файла##%mask%
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %dirBck% %mask% toBck %emails% %subject% %body%")

set mask=nl*.123.xml
set emails=umerenkova@crimea.genbank.ru#voroneckaya@crimea.genbank.ru
set subject=файл:#%mask%
set body=Поступило#уведомление#о#получении#файла##%mask%
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %dirBck% %mask% toBck %emails% %subject% %body%")

set mask=rc*.123.xml
set emails=e.sadovskaya@genbank.ru#zuek@genbank.ru
set subject=файл:#%mask%
set body=Поступило#уведомление#о#получении#файла##%mask%
where /r %from% /q %mask:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %dirBck% %mask% toBck %emails% %subject% %body%")

endlocal&exit /b 0

:send_incoming_attentions_to_users_and_move_to_arh
rem ======================================================================
echo  ** Рассылка уведомлений пользователям на email
rem ======================================================================
setlocal
set mask=*123GEBA
set from=r:\inc\
where /r %from% /q %mask:#= % > nul
if errorlevel 1 (endlocal&exit /b 0)
set subject=файл:#

set maskFiles=*123GEBA
set emails=popov@genbank.ru#s.navoenok@genbank.ru#p.saveliev@genbank.ru
set subject=Поступил#файл:#$file_name$
set body=Уведомление#о#получении#файла
where /r %from% /q %maskFiles:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmailsWithAttachment %from% %dirBck% %maskFiles% toBck %emails% %subject% %body%")

endlocal&exit /b 0

