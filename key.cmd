@echo off

rem ������� ��砩��� �ᥫ
call asrkeyw.exe

:loop
  cd c:\work.cmd&c:
  echo -------------------
  echo ��ࠡ�⪠ ���祩 550
  call lib\key_550.cmd
  echo -------------------
  echo ��ࠡ�⪠ ���祩 sign
  call lib\key_sign.cmd
  echo -------------------
  echo ��ࠡ�⪠ ���祩 encrypt
  call lib\key_encrypt.cmd
  echo -------------------
  echo ��ࠡ�⪠ ���祩 signatura
  call lib\key_signatura.cmd
  echo -------------------
  echo ��ࠡ�⪠ ����祭�
  echo -------------------

  timeout 3
goto loop