@echo off

:loop
  cd c:\work.cmd&c:
  echo -------------------
  echo �����娢���
  call lib\from_arj.cmd
  echo -------------------
  echo ��娢�஢����
  call lib\to_arj.cmd
  echo -------------------
  echo ��ࠡ�⪠ ����祭�
  echo -------------------

  timeout 120
goto loop