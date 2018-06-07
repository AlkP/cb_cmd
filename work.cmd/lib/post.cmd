::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem ��ࠡ�⪠ �� ����ᯮ����樨
rem =========================================

rem ������� ��६�����
call :setVariable
rem ��७�ᨬ pdf 䠩�� �� ������� ���
call :pdfIn
rem ��७�ᨬ pdf � ��娢 ����� � ��ࠢ�塞 㢥�������� �� email
call :pdfToArhAndSendEmail
rem ��७�ᨬ ��*.rar 䠩�� �� ������� ���
call :odIn
rem ��७�ᨬ 1234.rar 䠩�� �� ������� ���
call :numeralRarIn
rem �����娢��㥬 *.rar � ��娢 �� ᮮ�饭�� � ��ࠢ�塞 ���쬮 � ��뫪��
call :extractFromRarAndSend

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>






































:setVariable
rem ======================================================================
echo  ** ������� ��६�����
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

exit /b 0

:pdfIn
rem ======================================================================
echo  ** ��७�ᨬ pdf 䠩�� �� ������� ���
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
echo  ** ��७�ᨬ pdf � ��娢 ����� � ��ࠢ�塞 㢥�������� �� email
rem ======================================================================
setlocal
set from=c:\work\pdf\
set to=���슏����\��९�᪠#�#��\���#��\%date:~6,4%\%date:~6,4%%date:~3,2%\%date:~6,4%%date:~3,2%%date:~0,2%\
set mask=*.pdf
rem set emails=CRFilPriemnayaBucenko@crimea.genbank.ru#CRSecDel@crimea.genbank.ru#ludogovskaya@genbank.ru#priemnaya@genbank.ru#cb24@crimea.genbank.ru#va17@genbank.ru#s.navoenok@genbank.ru#popov@genbank.ru#p.saveliev@genbank.ru
set emails=CRFilPriemnayaBucenko@crimea.genbank.ru#CRSecDel@crimea.genbank.ru#priemnaya@genbank.ru
rem set emails=a.pasenko@crimea.genbank.ru
set subject=����㯨��#����:#$file_name$
rem ��� ������ ᯥ� ᨬ����
rem = = $1$    < = $2$    > = $3$
rem � � � � � � : <p>���쬮 ����㯭� �� <a href='%reportsTo:#= %%fileName%'>��뫪�</a></p>
rem             $2$p$3$���쬮#����㯭�#��#$2$a#href$1$'%to%$file_name$'$3$��뫪�$2$/a$3$$2$/p$3$
set body=$2$p$3$���쬮#����㯭�#��#$2$a#href$1$'%to%$file_name$'$3$��뫪�$2$/a$3$$2$/p$3$

where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFilesAndSendAttentionEmails %from% %to% %mask% toArh %emails% %subject% %body%")

endlocal&exit /b 0

:odIn
rem ======================================================================
echo  ** ��७�ᨬ ��*.rar 䠩�� �� ������� ���
rem ======================================================================
setlocal
set from=r:\inc\
set to=c:\work\fromRar\in\
set mask=��*.rar

where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "moveFile %from% %to% %mask% toLocal")

endlocal&exit /b 0

:numeralRarIn
rem ======================================================================
echo  ** ��७�ᨬ 1234.rar 䠩�� �� ������� ���
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
echo  ** �����娢��㥬 *.rar � ��娢 �� ᮮ�饭�� � ��ࠢ�塞 ���쬮 � ��뫪��
rem ======================================================================
setlocal
set from=c:\work\fromRar\in\
set to=���슏����\��९�᪠#�#��\���#��\%date:~6,4%\%date:~6,4%%date:~3,2%\%date:~6,4%%date:~3,2%%date:~0,2%\
set mask=*.rar
rem set emails=CRFilPriemnayaBucenko@crimea.genbank.ru#CRSecDel@crimea.genbank.ru#ludogovskaya@genbank.ru#priemnaya@genbank.ru#cb24@crimea.genbank.ru#va17@genbank.ru#k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru#s.navoenok@genbank.ru#popov@genbank.ru#p.saveliev@genbank.ru
set emails=CRFilPriemnayaBucenko@crimea.genbank.ru#CRSecDel@crimea.genbank.ru#priemnaya@genbank.ru#k.borovikov@crimea.genbank.ru#d.stetsurin@crimea.genbank.ru
set subject=����㯨��#����:#$file_name$
set body=$2$p$3$���쬮#����㯭�#��#$2$a#href$1$'%to%$file_name$'$3$��뫪�$2$/a$3$$2$/p$3$

where /r %from% /q %mask% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "extractFromRarAndSend %from% %to% %mask% %emails% %subject% %body%")

endlocal&exit /b 0



