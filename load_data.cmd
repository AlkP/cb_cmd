@echo off

:loop
  echo -------------------
  echo ���������� ��६�����
  call c:\work.cmd\lib\lib.cmd "setVariable"
  echo -------------------
  echo ���������� ���稪�� � ��娢��
  CountFilesInArh.exe %dirArhLong% S10123*.arj#ON10123*.arj#NN10123*.arj f311inArch %dateS%
  CountFilesInArh.exe %dirArhLong% AFN_MIFNS00_3510123_*.arj f440inArch %dateS%
  CountFilesInArh.exe %dirArhLong% AN10123*.arj#BN10123*.arj f311outArch %dateS%
  CountFilesInArh.exe %dirArhLong% AFN_3510123_MIFNS00_*.arj f440outArch %dateS%
  echo -------------------
  echo �஢�ઠ ࠡ��� �����
  CountFilesInFolder.exe "c:\work" * 20020202 srv9work 1
  CountFilesInFolder.exe "����⊏����\Post" * 20020202 srv69post 1
  CountFilesInFolder.exe "����⊏����\3251\OUT\003\ERR" * 20020202 f311err 1
  CountFilesInFolder.exe "����⊏����\440p\BRANCHES\0000\OUT\Err" * 20020202 f440err 1
  CountFilesInFolder.exe r:\inc */receipt.xml* 20020202 srv57inc 1
  CountFilesInFolder.exe r:\inc mz* 20020202 srv57inc_mz 1
  echo -------------------
  echo �஢�ઠ ��������� 311 xml 䠩���
  XmlValidator.exe c:\work\diasoft\TEMP_311\ c:\work\diasoft\out_311p\ c:\work\diasoft\TEMP_311\err\
  echo -------------------
  echo ��७�� �� �஢��� 440 xml 䠩���
  where /r c:\work\diasoft\TEMP_440\ /q * > nul
  if not errorlevel 1 (
    call %dirLib%lib.cmd "moveFile c:\work\diasoft\TEMP_440\ c:\work\diasoft\out_440p\ *.xml fromDiasoft2"
  )
  echo -------------------
  echo ��२��������� � ��७�� 440 xml 䠩���
  set dirSystemOut440p=c:\work\diasoft\out_440p\
  set     dirSystemOut=c:\work\diasoft\out\
  set         fileMask=PB?_????3510123_*.xml#????_????3510123_*.vrb
  set fileMaskToRename=????_????3510123_*.xml
  where /r %dirSystemOut440p% /q * > nul
  if not errorlevel 1 (
    ren %dirSystemOut440p%%fileMaskToRename% *.vrb
    call %dirLib%lib.cmd "moveFile %dirSystemOut440p% %dirSystemOut% %fileMask% fromDiasoft"
  )
  echo -------------------
  echo ��ࠡ�⪠ ��娢��
  set pathS=c:\files.logs\%dateS:~0,4%.%dateS:~4,2%.%dateS:~6,2%\
  DoRelation.exe %dateS% %pathS%
  echo -------------------
  echo ���������� �痢�
  Sqlcmd -S MSSQLSERVER -U UserName -P UserPassword -i c:\Utils\update_trelations.sql -o c:\Utils\update_trelations.rpt
  echo -------------------
  echo ��ࠡ�⪠ xml
  KwitParser.exe %dateS% %dirArhLong%
  timeout 5
  echo -------------------
  echo ���������� IZVTUB success
  Sqlcmd -S MSSQLSERVER -U UserName -P UserPassword -i c:\Utils\update_tfiles.sql -o c:\Utils\update_tfiles.rpt
  echo -------------------
  echo ��ࠡ�⪠ ����祭�
  echo -------------------

  timeout 420
goto loop