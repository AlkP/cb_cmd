@echo off

:loop
  cd c:\work.cmd&c:
  echo -------------------
  echo Разархивация
  call lib\from_arj.cmd
  echo -------------------
  echo Архивирование
  call lib\to_arj.cmd
  echo -------------------
  echo Обработка окончена
  echo -------------------

  timeout 120
goto loop