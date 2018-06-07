@echo off

:loop
  cd c:\work.cmd&c:
  echo -------------------
  echo Пакеты 440 положения
  call lib\mz.cmd
  echo -------------------
  echo Обработка окончена
  echo -------------------

  timeout 15
goto loop

