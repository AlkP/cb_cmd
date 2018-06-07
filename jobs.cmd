@echo off

:loop
  cd c:\work.cmd&c:
  echo -------------------
  echo Проверка уникальности входящих файлов за день
  call lib\checkUniqueness.cmd
  echo -------------------
  echo Обработка 311 формы
  call lib\form_311.cmd
  echo -------------------
  echo Обработка 364 формы
  call lib\form_364.cmd
  echo -------------------
  echo Обработка 440 формы
  call lib\form_440.cmd
  echo -------------------
  echo Обработка 550 формы
  call lib\form_550.cmd
  echo -------------------
  echo Обработка 4489 формы
  call lib\form_4498.cmd
  echo -------------------
  echo Обработка 4512 формы
  call lib\form_4512.cmd
  echo -------------------
  echo Обработка 0m
  call lib\0m.cmd
  echo -------------------
  echo Обработка почты
  call lib\post.cmd
  echo -------------------
  echo Обработка отчетов
  call lib\reports.cmd
  echo -------------------
  echo Обработка окончена
  echo -------------------

  timeout 3
goto loop