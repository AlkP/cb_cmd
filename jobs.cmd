@echo off

:loop
  cd c:\work.cmd&c:
  echo -------------------
  echo �஢�ઠ 㭨���쭮�� �室��� 䠩��� �� ����
  call lib\checkUniqueness.cmd
  echo -------------------
  echo ��ࠡ�⪠ 311 ���
  call lib\form_311.cmd
  echo -------------------
  echo ��ࠡ�⪠ 364 ���
  call lib\form_364.cmd
  echo -------------------
  echo ��ࠡ�⪠ 440 ���
  call lib\form_440.cmd
  echo -------------------
  echo ��ࠡ�⪠ 550 ���
  call lib\form_550.cmd
  echo -------------------
  echo ��ࠡ�⪠ 4489 ���
  call lib\form_4498.cmd
  echo -------------------
  echo ��ࠡ�⪠ 4512 ���
  call lib\form_4512.cmd
  echo -------------------
  echo ��ࠡ�⪠ 0m
  call lib\0m.cmd
  echo -------------------
  echo ��ࠡ�⪠ �����
  call lib\post.cmd
  echo -------------------
  echo ��ࠡ�⪠ ���⮢
  call lib\reports.cmd
  echo -------------------
  echo ��ࠡ�⪠ ����祭�
  echo -------------------

  timeout 3
goto loop