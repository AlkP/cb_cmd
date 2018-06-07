@echo off

rem генератор случайных чисел
call asrkeyw.exe

:loop
  cd c:\work.cmd&c:
  echo -------------------
  echo Обработка ключей 550
  call lib\key_550.cmd
  echo -------------------
  echo Обработка ключей sign
  call lib\key_sign.cmd
  echo -------------------
  echo Обработка ключей encrypt
  call lib\key_encrypt.cmd
  echo -------------------
  echo Обработка ключей signatura
  call lib\key_signatura.cmd
  echo -------------------
  echo Обработка окончена
  echo -------------------

  timeout 3
goto loop