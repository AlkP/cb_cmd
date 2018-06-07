@echo off
set time1=61
set time2=67
PSDNotifier.exe %time1% > nul
if errorlevel 1 (
  echo ------------- Старт лога > errorMonitor.txt
  PSDNotifier.exe %time2% >> errorMonitor.txt
  echo -------------  Конец лога >> errorMonitor.txt
  echo . >> errorMonitor.txt
  echo Журнал доступен по ссылке: http://rails_server:3030 >> errorMonitor.txt
  convertcp.exe 866 1251 /i "errorMonitor.txt" /o "errorMonitorCP1251.txt"
  SwithMail /s /from "user@test.ru" /to "test1@test.ru; test2@test.ru" /u "User" /pass "UserPassword" /SSL "True" /HTML "false" /Server "EmailServer" /p "25" /sub "Ошибка на мониторе ПТКПСД"  /btxt errorMonitorCP1251.txt 
  del errorMonitorCP1251.txt
  del errorMonitor.txt
)