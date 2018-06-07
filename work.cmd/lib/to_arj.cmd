::<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
rem =========================================
rem �������� ��娢��
rem =========================================

rem ������� ��६�����
call :setVariable
rem ������� ��娢 AFD
rem call :AFD
rem ������� ��娢 AFN
call :AFN
rem ��������� ��娢� �� UV_2490_0000_CB_ES550P*.xml 䠩���
call :ARH550P
rem ��������� ��娢� �� PS*_2490_0000.xml 䠩���
call :ARH364P
rem ������� ��娢 AN
call :AN
rem ������� ��娢 BN
call :BN
rem ��ࠢ�� ��娢�� � ��⥬�
call :move_arj_to_system

exit /b 0

::>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>








































:setVariable
rem ======================================================================
echo  ** ������� ��६�����
rem ======================================================================
rem set common variables
call c:\work.cmd\lib\lib.cmd "setVariable"

set       arjIn=c:\work\to_arj\in\
set      arjOut=c:\work\to_arj\out\

set dirDiasoftOutBefore=c:\work\diasoft\out\

set    maskBVS=BVS?_????3510123_*.vrb
set maskAnswer=PB?_????3510123_*.xml#BNS?_????3510123_*.vrb#ZBN?_????3510123_*.vrb#BOS?_????3510123_*.vrb#RBN?_????3510123_*.vrb
set maskAnswer=%maskAnswer%#ZBO?_????3510123_*.vrb#BVD?_????3510123_*.vrb#BNP?_????3510123_*.vrb#BVS?_????3510123_*.vrb
set mask311fAN=SFC??3510123_????????????_24900000??????????_0??.xml#SBC??3510123_????????????_24900000??????????_0??.xml#SFC??3510123_????????????_24900000??????????_1??.xml#SBC??3510123_????????????_24900000??????????_1??.xml#SFC??3510123_????????????_24900000??????????_2??.xml#SBC??3510123_????????????_24900000??????????_2??.xml#SFC??3510123_????????????_24900000??????????_6??.xml#SBC??3510123_????????????_24900000??????????_6??.xml
set mask311fBN=SFC??3510123_????????????_24900000??????????_3??.xml#SBC??3510123_????????????_24900000??????????_3??.xml#SFC??3510123_????????????_24900000??????????_4??.xml#SBC??3510123_????????????_24900000??????????_4??.xml#SFC??3510123_????????????_24900000??????????_5??.xml#SBC??3510123_????????????_24900000??????????_5??.xml#SFC??3510123_????????????_24900000??????????_7??.xml#SBC??3510123_????????????_24900000??????????_7??.xml
set    maskAFN=AFN_3510123_MIFNS00_%dateS%_
set    maskAFD=AFD_3510123_MIFNS00_%dateS%_
set     maskAN=AN10123%dateShort%
set     maskBN=BN10123%dateShort%
set   mask550P=ARH550P_2490_0000_%dateS%_
set fileMaskUV=UV_2490_0000_CB_ES550P*.xml

exit /b 0

:AFD
rem ======================================================================
echo  ** ������� ��娢 AFD
rem ======================================================================
where /r %arjIn% /q %maskBVS% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "toArj %arjIn% %arjOut% %maskBVS% %maskAFD% f440 5 50 toArj")
exit /b 0

:AFN
rem ======================================================================
echo  ** ������� ��娢 AFN
rem ======================================================================
where /r %arjIn% /q %maskAnswer:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "toArj %arjIn% %arjOut% %maskAnswer% %maskAFN% f440 5 50 toArj")
exit /b 0

:AN
rem ======================================================================
echo  ** ������� ��娢 AN
rem ======================================================================
where /r %arjIn% /q %mask311fAN:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "toArj %arjIn% %arjOut% %mask311fAN% %maskAN% f311 4 500 toArj")
exit /b 0

:BN
rem ======================================================================
echo  ** ������� ��娢 BN
rem ======================================================================
where /r %arjIn% /q %mask311fBN:#= % > nul
if not errorlevel 1 (call %dirLib%lib.cmd "toArj %arjIn% %arjOut% %mask311fBN% %maskBN% f311 4 500 toArj")
exit /b 0

:ARH550P
rem ======================================================================
echo  ** ��������� ��娢� �� UV_2490_0000_CB_ES550P*.xml 䠩���
rem ======================================================================
where /r %arjIn% /q %fileMaskUV% > nul
if not errorlevel 1 (call %dirLib%lib.cmd "toArj %arjIn% %arjOut% %fileMaskUV% %mask550P% f550 3 10 toArj")
exit /b 0

:ARH364P
rem ======================================================================
echo  ** ��������� ��娢� �� PS*_2490_0000.xml 䠩���
rem ======================================================================
set fileMask364=PS*_2490_0000.xml
where /r %arjIn% /q %fileMask364% > nul
if not errorlevel 1 (TransactionPassport.exe %arjIn% %arjOut%)
exit /b 0

:move_arj_to_system
rem ======================================================================
echo  ** ��ࠢ�� ��娢�� � ��⥬�
rem ======================================================================
where /r %arjOut% /q * > nul
if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %arjOut% %dirArhLong% %dirDiasoftOutBefore% * toBck inOutgoing")
rem if not errorlevel 1 (call %dirLib%lib.cmd "copyAndMoveFile %arjOut% %dirArhLong% %dirDiasoftOutBefore% * toBck inOutgoing CreateList %dirArh%%timeSm%.list")
exit /b 0
