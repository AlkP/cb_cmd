@echo off

:loop
  cd c:\work.cmd&c:
  echo -------------------
  echo Движение файлов между машиной со скриптами и Diasoft
  call lib\diasoft.cmd
  echo -------------------
  echo Обработка окончена
  echo -------------------

  timeout 15
goto loop