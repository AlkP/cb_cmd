@echo off
cd c:\work.cmd&c:
:loop
  start "�஢�ઠ �訡��..." cmd /c C:\work.cmd\lib\test_send.cmd
  timeout 60
goto loop