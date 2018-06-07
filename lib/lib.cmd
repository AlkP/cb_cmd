call :%~1
GOTO:EXIT

rem :setVariable                                   Задание переменных
rem :setTime                                       Задаем глабальные переменные времени
rem :writeLog                                      Создаем файл лога
rem :getBatchFolder                                Сохраняем текущий каталог в переменную
rem :saveListArh                                   Сохраняем список файлов архива в файл

rem :workWithVerbaKey                              Работа с ключами Verba
rem :workWithSignaturaKey                          Работа с ключами Signatura
rem :moveFile                                      Функция переноса файлов
rem :copyFile                                      Функция копирования файлов
rem :moveDouble                                    Перeнос файлов, если в папке назначения существует уже файл происходит переименование по маске 
                                                   rem ИмяФайла -> №@ИмяФайла, где № номер по порядку

rem :copyDouble                                    Копирование файлов, если в папке назначения существует уже файл происходит переименование по маске 
                                                   rem ИмяФайла -> №@ИмяФайла, где № номер по порядку
rem :copyAndMoveFile                               Функция одновременного копирования и переноса файлов
rem :createUVfilesAndMoveToBck                     Создание ответа по 550 положению и перемещение оригинала в архив
rem :extractFromArj                                Разархивирование файлов
rem :extractFromArjRR                              разархиваровать архивы содержащие дубликаты

rem :checkUniqueness                               Проверка файла, что имя уникально за день
rem :checkUniquenessArj                            Сортируем архивы
rem :checkUniquenessRR                             Проверяем, что поступивший дубль можно начинать обрабатывать
rem :checkSchedule                                 Проверка расписания работы
rem :toArj                                         Помещаем в архив по маске

rem :moveFilesAndSendEmails                        Перемещаем файл и отправляем email, тело письма - содержимое файла
rem :moveFilesAndSendAttentionEmailsWithAttachment Перемещаем файл и отправляем информационный email с attachment с файлом
rem :moveFilesAndSendAttentionEmails               Перемещаем файл и отправляем информационный email
rem :extractFromRarAndSend                         Разархивируем файл и отправляем информационный email
rem :fromCab                                       Извлекаем из cab файлов по маске

























:setVariable
rem ======================================================================
rem Задаем глобальные переменные
rem ======================================================================
if "%time:~0,1%"==" " (set tme=0%time:~1,1%) else (set tme=%time:~0,2%)
set      dateS=%date:~6,4%%date:~3,2%%date:~0,2%
set  dateShort=%date:~8,2%%date:~3,2%%date:~0,2%
set      dateL=%date:~6,4%.%date:~3,2%.%date:~0,2%
set   dateLong=%date:~6,4%\%date:~6,4%.%date:~3,2%\%date:~6,4%.%date:~3,2%.%date:~0,2%
set   dateArch=%date:~6,4%\%date:~3,2%\%date:~0,2%
set      timeS=%tme%%time:~2,3%
set     timeSn=%tme%%time:~3,2%%time:~6,2%
set      timeL=%tme%%time:~2,9%
set   timeLong=%tme%%time:~3,2%%time:~6,2%%time:~9,2%

rem set     dirArh=\\cr-ptkpsdv2\files.arh\
rem set     dirLib=\\cr-ptkpsdv2\work.cmd\lib\

set     dirArh=c:\files.arh\
set     dirLib=c:\work.cmd\lib\

set dirArhLong=%dirArh%%dateLong%\
set    dirWork=c:\work\processing\
set     dirBck=c:\files.bck\%dateL%\
set    dirLogs=c:\files.logs\%dateL%\

if not exist "%dirArhLong:#= %" mkdir "%dirArhLong:#= %"
if not exist "%dirBck:#= %" mkdir "%dirBck:#= %"
if not exist "%dirLogs:#= %" mkdir "%dirLogs:#= %"

rem расписание пятницы: schedule02, schedule04time
rem Пакеты mz: schedule03dweek, schedule05time
rem рабочие время
set   schedule01time=09:00#16:00
set   schedule02time=09:00#15:00
set   schedule03time=09:00#16:50
set   schedule04time=09:00#15:50
set   schedule05time=09:00#12:30
rem рабочие дни
rem set  schedule01dweek=1#2#3#4
rem set  schedule02dweek=5
rem set  schedule03dweek=1#2#3#4#5
set  schedule01dweek=1#2#3#4
set  schedule02dweek=5
set  schedule03dweek=1#2#3#4#5

call :setTime
exit /b


:setTime
rem ======================================================================
rem Задаем глабальные переменные времени
rem ======================================================================
if "%time:~0,1%"==" " (set tme=0%time:~1,1%) else (set tme=%time:~0,2%)
set timeSn=%tme%%time:~3,2%%time:~6,2%
set timeSm=%tme%%time:~3,2%%time:~6,2%%time:~9,2%
exit /b


:writeLog %file% %action% %from% %to% %msg%
rem ======================================================================
rem Создаем файл лога
rem ======================================================================
rem file   - файл по которому создается лог
rem action - действие с файлом
rem from   - путь источник
rem to     - путь назначение
rem msg    - сообщение
rem 
rem dirLogs - куда записываются логи, задается в глобальных переменных
rem ======================================================================
setlocal
call :setVariable
set file=%1&set action=%2&set from=%3&set to=%4&set msg=%5
rem call set msg=%%msg:%1=%%&call set msg=%%msg:%2=%%
rem call set msg=%msg:~2,999%
echo @@@%dateL% %timeL%@@@%file%@@@%action%@@@%from%@@@%to%@@@%msg%@@@ >> %dirLogs%%file%.log
endlocal&exit /b 0


:getBatchFolder returnVar
rem ======================================================================
rem Сохраняем текущий каталог в переменную
rem ======================================================================
rem returnVar - переменная в которую сохраняем каталог
rem ======================================================================
rem пример использования c с переходом в каталог
rem call :getBatchFolder homeFolder
rem cd %homeFolder%&%homeFolder:~0,2%
rem ======================================================================
set "%~1=%~dp0"&exit /b


:saveListArh %arh% %listFile%
rem ======================================================================
rem Сохраняем список файлов архива в файл
rem ======================================================================
rem arh      - архив
rem listFile - куда сохраняем список
rem ======================================================================
setlocal ENABLEEXTENSIONS
call :setVariable
set tmpFile=%dirLogs%%timeSn%
:saveListArhLoop
(7z l -slt %1 | find /i "Path =" | more +1)>%tmpFile%
(For /F "tokens=3" %%i In (%tmpFile%) Do (
  echo %%i
))>%2
for /f %%a in ('dir /b /s /a-d "%2"') do (
  if %%~za EQU 0 (
    timeout 12
    call :writeLog %~nx1 listDontCreate
    goto :saveListArhLoop
  )
)
del /Q %tmpFile%
endlocal&exit /b


:workWithVerbaKey %dirWorkVerba% %action% %option%
rem ======================================================================
rem Работа с ключами Verba
rem ======================================================================
rem dirWorkVerba - директория для работы с файлом
rem                dirWorkVerba\in    - вх
rem                dirWorkVerba\out   - исх
rem                dirWorkVerba\error - если при работе с файлом произоша ошибка
rem action       - какое действие запишется в лог файл
rem option       - параметр запуска работы с ключом
rem ======================================================================
setlocal
set dirWorkVerba=%1&set action=%2&set option=%3
set option=%option:#= %
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON "%dirWorkVerba%in\*" > %listFiles%
timeout 3
for /f "tokens=*" %%I in (%listFiles%) do (
  SCSignEx %option% -ga:\ -ia:\ -b0 -f%dirWorkVerba%in\%%I -va:\ -wa:\
  if not errorlevel 1 (
    call :writeLog %%I %action% %dirWorkVerba%in\ %dirWorkVerba%out\
    move "%dirWorkVerba%in\%%I" "%dirWorkVerba%out\"
  ) else (
    move "%dirWorkVerba%in\%%I" "%dirWorkVerba%error\"
  )
)
del %listFiles%
endlocal&exit /b 0


:workWithSignaturaKey %dirWorkSignatura% %action% %option%
rem ======================================================================
rem Работа с ключами Signatura
rem ======================================================================
rem dirWorkSignatura - директория для работы с файлом
rem                    dirWorkSignatura\in    - вх
rem                    dirWorkSignaturaa\out   - исх
rem                    dirWorkSignatura\error - если при работе с файлом произоша ошибка
rem action           - какое действие запишется в лог файл
rem option           - параметр запуска работы с ключом
rem ======================================================================
setlocal
set dirWorkSignatura=%1&set action=%2&set option=%3
call :setTime
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON "%dirWorkSignatura%in\*" > %listFiles%
timeout 3
for /f "tokens=*" %%I in (%listFiles%) do (
  call %option% %%I %dirWorkSignatura%in %dirWorkSignatura%out
  if not errorlevel 1 (
    call :writeLog %%I %action% %dirWorkSignatura%in\ %dirWorkSignatura%out\
    del /Q %dirWorkSignatura%in\%%I
  ) else (
    move "%dirWorkSignatura%in\%%I" "%dirWorkSignatura%error\"
  )
)
del %listFiles%
endlocal&exit /b 0


:moveFile %from% %to% %mask% %actionName% %list% %fileForList%
rem ======================================================================
rem Функция переноса файлов
rem ======================================================================
rem from        - папка источник
rem to          - папка назначение
rem mask        - маска переносимых файлов, можно передавать несколько. Пример: *.arj#*.txt
rem actionName  - "действие" для лога 
rem list        - необязательный параметр либо не задан, либо "CreateList" и тогда будет создан список переносимых файлов
rem fileForList - файл для создания списка переносимых файлов
rem ======================================================================
setlocal
set from=%1&set to=%2&set mask=%3&set actionName=%4&set createList=%5&set fileForList=%6
set mask=%mask:#= %
echo from %from:~0,35% to %to:~0,35% ## %mask%
call :setVariable
set listFiles=%dirLogs%%timeSm%.files
call :getBatchFolder homeFolder
cd /d %from%
dir /b /ON %mask% > %listFiles%
timeout 4
if not exist "%to:#= %" mkdir "%to:#= %"
for /f "tokens=*" %%I in (%listFiles%) do (
  call :moveDouble %from% %to% %%I
  rem move %from%%%I %to%
  if "%createList%"=="CreateList" (echo %to%%%I >> "%fileForList%")
  call :writeLog %%I %actionName% %from% %to%
)
if not "%homeFolder:~0,2%"=="\\" (cd /d %homeFolder%)
del %listFiles%
endlocal&exit /b 0


:copyFile %from% %to% %mask% %actionName% %list% %fileForList%
rem ======================================================================
rem Функция копирования файлов
rem ======================================================================
rem from        - папка источник
rem to          - папка назначение
rem mask        - маска копируемых файлов
rem actionName  - "действие" для лога 
rem list        - необязательный параметр либо не задан, либо "CreateList" и тогда будет создан список копируемых файлов
rem fileForList - файл для создания списка копируемых файлов
rem ======================================================================
setlocal
set from=%1&set to=%2&set mask=%3&set actionName=%4&set createList=%5&set fileForList=%6
set mask=%mask:#= %
call :setVariable
set listFiles=%dirLogs%%timeSm%.files
call :getBatchFolder homeFolder
cd /d %from%
dir /b /ON %mask% > %listFiles%
timeout 4
if not exist "%to:#= %" mkdir "%to:#= %"
for /f "tokens=*" %%I in (%listFiles%) do (
  call :copyDouble %from% %to% %%I
  rem copy %from%%%I %to%
  call :writeLog %%I %actionName% %from% %to%
  if "%createList%"=="CreateList" (echo %to%%%I >> "%fileForList%")
)
if not "%homeFolder:~0,2%"=="\\" (cd /d %homeFolder%)
del %listFiles%
endlocal&exit /b 0


:moveDouble %from% %to% %fileName%
rem ======================================================================
rem Перeнос файлов, если в папке назначения существует уже файл происходит
rem переименование по маске ИмяФайла -> №@ИмяФайла, где № номер по порядку
rem ======================================================================
set k=0
set from=%1&set to=%2
set from=%from:#= %
set to=%to:#= %
if not exist "%to%" mkdir "%to%"
if not exist "%to%%3" ((move "%from%%3" "%to%")&exit /b 0)
:moveDoubleLoop
set /a k=%k%+1
if exist "%to%%~n3$%k%%~x3" goto :moveDoubleLoop
move "%from%%3" "%to%%~n3$%k%%~x3"
exit /b 0


:copyDouble %from% %to% %fileName%
rem ======================================================================
rem Копирование файлов, если в папке назначения существует уже файл происходит
rem переименование по маске ИмяФайла -> №@ИмяФайла, где № номер по порядку
rem ======================================================================
set k=0
set from=%1&set to=%2
set from=%from:#= %
set to=%to:#= %
if not exist "%to:#= %" mkdir "%to:#= %"
if not exist "%to%%3" ((copy "%from%%3" "%to%")&exit /b 0)
:copyDoubleLoop
set /a k=%k%+1
if exist "%to%%~n3$%k%%~x3" goto :copyDoubleLoop
copy "%from%%3" "%to%%~n3$%k%%~x3"
exit /b 0


:copyAndMoveFile %from% %toCopy% %toMove% %mask% %actionCopy% %actionMove% %list% %fileForList%
rem ======================================================================
rem Функция одновременного копирования и переноса файлов
rem ======================================================================
rem from        - папка источник
rem toCopy      - папка назначение для копирования
rem toMove      - папка назначение для перемещения
rem mask        - маска копируемых файлов
rem actionCopy  - "действие" для лога копирования
rem actionMove  - "действие" для лога перемещения
rem list        - необязательный параметр либо не задан, либо "CreateList" и тогда будет создан список копируемых файлов
rem fileForList - файл для создания списка копируемых файлов
rem ======================================================================
setlocal
set from=%1&set toCopy=%2&set toMove=%3&set mask=%4&set actionCopy=%5&set actionMove=%6&set createList=%7&set fileForList=%8
set mask=%mask:#= %
call :setVariable
set listFiles=%dirLogs%%timeSm%.files
call :getBatchFolder homeFolder
cd /d %from%
dir /b /ON %mask% > %listFiles%
timeout 3
if not exist "%toCopy:#= %" mkdir "%toCopy:#= %"
if not exist "%toMove:#= %" mkdir "%toMove:#= %"
for /f "tokens=*" %%I in (%listFiles%) do (
  rem copy %from%%%I %toCopy%
  call :copyDouble %from% %toCopy% %%I
  rem move %from%%%I %toMove%
  call :moveDouble %from% %toMove% %%I
  if "%createList%"=="CreateList" (echo %toCopy%%%I >> "%fileForList%")
  rem if "%createList%"=="CreateList" (echo %toMove%%%I >> "%fileForList%")
  call :writeLog %%I %actionCopy% %from% %toCopy%
  call :writeLog %%I %actionMove% %from% %toMove%
)
if not "%homeFolder:~0,2%"=="\\" (cd /d %homeFolder%)
del %listFiles%
endlocal&exit /b 0


:createUVfilesAndMoveToBck %from% %to% %bck% %mask%
rem ======================================================================
rem Создание ответа по 550 положению
rem ======================================================================
rem from - где лежат запросы
rem to   - куда сохранять ответы
rem bck  - папка для архива
rem mask - маска файла
rem ======================================================================
setlocal
set from=%1&set to=%2&set bck=%3&set mask=%4
call :setTime
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON "%from%%mask%" > %listFiles%
timeout 4
for /f "tokens=*" %%I in (%listFiles%) do (
  call :writeLog %%I beforeCreateUV %from% %to% UV_2490_0000_%%I
  call UV_550.vbs %%I %from% %to%
  timeout 1
  call :writeLog %%I createUV %from% %to% UV_2490_0000_%%I
)
timeout 7
for /f "tokens=*" %%I in (%listFiles%) do (
  call :writeLog %%I toBck %from% %bck%
  call :moveDouble %from% %bck% %%I
)
del %listFiles%
endlocal&exit /b 0


:extractFromArj %from% %to% %mask%
rem ======================================================================
rem Разархивирование файлов
rem ======================================================================
rem from - директория с архивами
rem to   - папка назначение для архивов
rem mask - маска разархивируемых файлов
rem ======================================================================
setlocal enableextensions enabledelayedexpansion
set from=%1&set to=%2&set mask=%3
call :setVariable
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON "%from%%mask%" > %listFiles%
timeout 7
for /f "tokens=*" %%I in (%listFiles%) do (
  call :writeLog %%I beforeExtract %from% %to%
  arj.exe e %from%%%I %to%
  if not errorlevel 1 (
    call :writeLog %%I extract %from% %to%
    call :setTime
    call :saveListArh %from%%%I %dirLogs%%%I.%timeSn%.list
    call :moveDouble %from% %dirArhLong% %%I
    call :writeLog %%I toBck %from% %dirArhLong%
  )
)
del %listFiles%&endlocal&exit /b 0


:extractFromArjRR %from% %tmp% %to% %toRR% %mask%
rem ======================================================================
rem разархиваровать архивы содержащие дубликаты
rem ======================================================================
rem from - откуда разархиваровать 
rem        !ВАЖНО! здесь же должен лежать файл с именем ИмяАрхива.arj.HHMMSS.list
rem        в нем имена дублей
rem tmp  - папка для временно разархивированных
rem        !ВАЖНО! во временной папке не должно быть файлов от предыдущих шагов
rem to   - куда переносить файлы после разархивации
rem toRR - куда переносить дубли после разархивации
rem ======================================================================
setlocal enableextensions enabledelayedexpansion
set from=%1&set tmp=%2&set to=%3&set toRR=%4&set mask=%5
call :setVariable

where /r %tmp% /q * > nul
if not errorlevel 1 (endlocal&exit /b 0)

set listFiles=%dirLogs%%timeSm%.files
dir /b /ON "%from%%mask%" > %listFiles%
timeout 3
for /f "tokens=*" %%I in (%listFiles%) do (
  arj.exe e %from%%%I %tmp%
  if not errorlevel 1 (
    call :writeLog %%I extract %from% %tmp%
    call :setTime
    call :saveListArh %from%%%I %dirLogs%%%I.%timeSn%.list
    call :moveDouble %from% %dirArhLong% %%I
    call :writeLog %%I toBck %from% %dirArhLong%
  )
  for /f "tokens=*" %%F in ('dir /b /ON "%from%%%I.??????.list"') do (
    echo %tmp%%%F
    for /f "tokens=*" %%L in (%from%%%F) do (
      echo %%L
      where /r %toRR% /q %%L > nul
      if not errorlevel 1 (
        call :moveDouble %tmp% %from% %%L
        call :writeLog %%L moveAfterExtract %tmp% %from%
      ) else (
        call :moveDouble %tmp% %toRR% %%L
        call :writeLog %%L moveAfterExtract %tmp% %toRR%      
      )
    )
    del /Q %from%%%F
  )
  call :moveFile %tmp% %to% * moveAfterExtract
)
del %listFiles%&endlocal&exit /b 0


:checkUniqueness %from% %toOk% %toError% %mask%
rem ======================================================================
rem Проверка файла, что имя уникально за день
rem ======================================================================
rem from    - вх папка
rem toOk    - исх папка если имя файла уникально
rem toError - исх папка если дубль
rem mask    - маска обрабатываемых файлов
rem ======================================================================
setlocal enableextensions enabledelayedexpansion
set from=%1&set toOk=%2&set toError=%3&set mask=%4
call :setTime
set   listFiles=%dirLogs%%timeSm%.files
set listRRFiles=%dirLogs%rr.%timeSm%.files
set  listDFiles=%dirLogs%difference.%timeSm%.files
dir /b /ON "%from%%mask%" > %listFiles%
timeout 6
CheckUniqueness.exe %dateS% "%listFiles%" "%listRRFiles%"
if errorlevel 1 (
  for /f "tokens=*" %%I in (%listRRFiles%) do (
    call :moveDouble %from% %toError% %%I
    call :writeLog %%I reRiceipt %from% %toError%
  )
  (For /F "tokens=* usebackq" %%J In ("%listFiles%") Do (
    Set fl=0
    For /F "tokens=* usebackq" %%K In ("%listRRFiles%") Do If %%J==%%K Set fl=1
    If !fl!==0 Echo %%J
  ))>"%listDFiles%"
  del %listRRFiles%
  move /Y "%listDFiles%" "%listFiles%"
)
for /f "tokens=*" %%I in (%listFiles%) do (
  call :moveDouble %from% %toOk% %%I
  call :writeLog %%I inOutgoing %from% %toOk%
)
del %listFiles%
endlocal&exit /b 0


:checkUniquenessArj %from% %toOk% %toError% %mask%
rem ======================================================================
rem Сортируем архивы
rem ======================================================================
rem from    - вх директория архивов
rem toOk    - исх директория если архив не содержит дублей
rem toError - исх директория если архив содержит дубли
rem mask    - маска обрабатываемых файлов
rem ======================================================================
setlocal
set from=%1&set toOk=%2&set toError=%3&set mask=%4
set tmp=%timeSn%.list.uniqueness
call :setTime
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON "%from%%mask%" > %listFiles%
timeout 9
for /f "tokens=*" %%I in (%listFiles%) do (
  call :writeLog %%I toCreateListUniqueness %from%
  call :saveListArh %from%%%I %from%%%I.%tmp%
  call :writeLog %%I checkUniqueness %from%
  CheckUniqueness.exe %dateS% "%from%%%I.%tmp%" "%toError%%%I.%tmp%"
  if not errorlevel 1 (
    call :moveDouble %from% %toOk% %%I
    rem move "%from%%%I" "%toOk%"
    call :writeLog %%I toExtract %from% %toOk%
  ) else (
    call :moveDouble %from% %toError% %%I
    rem move "%from%%%I" "%toError%"
    call :writeLog %%I reRiceipt %from% %toError%
  )
  rem del /Q %from%%%I.%tmp%
  call :moveDouble %from% %dirLogs% %%I.%tmp%
)
del %listFiles%
endlocal&exit /b 0


:checkUniquenessRR %from% %to% %action%
rem ======================================================================
rem Проверяем, что поступивший дубль можно начинать обрабатывать
rem ======================================================================
rem from   - вх каталог
rem to     - исх каталог
rem action - если параметр задан, то он будет использован для задания действия в лог
rem ======================================================================
setlocal
set from=%1&set to=%2
call :setTime
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON "%from%*" > %listFiles%
for /f "tokens=*" %%I in (%listFiles%) do (
  echo %%I
  where /r c:\work\cb_check\ok\ /q %%I > nul
  if not errorlevel 1 goto :exit_checkUniquenessRR
  where /r c:\work\diasoft_check\ok\ /q %%I > nul
  if not errorlevel 1 goto :exit_checkUniquenessRR
  where /r c:\work\diasoft\ /q %%I > nul
  if not errorlevel 1 goto :exit_checkUniquenessRR
  where /r c:\work\from_arj\ /q %%I > nul
  if not errorlevel 1 goto :exit_checkUniquenessRR
  where /r c:\work\processing\ /q %%I > nul
  if not errorlevel 1 goto :exit_checkUniquenessRR
  where /r c:\work\to_arj\ /q %%I > nul
  if not errorlevel 1 goto :exit_checkUniquenessRR
  move "%from%%%I" "%to%"
  if "%3" EQU "" (call :writeLog %%I inIncoming %from% %to%) else (call :writeLog %%I %3 %from% %to%)
  )
)
:exit_checkUniquenessRR
del %listFiles%&endlocal&exit /b 0


:checkSchedule %dateToCheck% %timeToCheck% %scheduleDweek% %scheduleTime%
rem ======================================================================
rem Проверка расписания работы
rem ======================================================================
rem dateToCheck   - дата на проверку,  формат: 2017.08.29
rem timeToCheck   - время на проверку, формат: 09:46
rem scheduleDweek - расписание рабочих дней
rem scheduleTime  - расписание рабочих часов
rem ----------------------------------------------------------------------
rem checkResult - возвращаемая переменная в которой true/false попадания запрашиваемого времени в расписание
rem ======================================================================
:: format: dd.mm.yyyy  time: hh:mm
set dateToCheck=%1&set timeToCheck=%2
set scheduleDweek=%3&set scheduleTime=%4
set scheduleDweek=%scheduleDweek:#= %
set /a h1=1%scheduleTime:~0,2%-100
set /a m1=1%scheduleTime:~3,2%-100
set /a h2=1%scheduleTime:~6,2%-100
set /a m2=1%scheduleTime:~9,2%-100

set /a timeToCheckH=1%timeToCheck:~0,2%-100&set /a timeToCheckM=1%timeToCheck:~3,2%-100
set /a y=%dateToCheck:~0,4%&set /a m=1%dateToCheck:~5,2%-100&set /a d=1%dateToCheck:~8,2%-100
set /a i=(%y%-1901)*365 + (%y%-1901)/4 + %d% + (!(%y% %% 4))*(!((%m%-3)^&16))
set /a i=(%i%+(%m%-1)*30+2*(!((%m%-7)^&16))-1+((65611044^>^>(2*%m%))^&3))%%7+1
set checkResult=false

for %%x in (%scheduleDweek%) do (
  rem ==
  if %%x EQU %i% (
    rem >
    if %timeToCheckH% GTR %h1% (
      rem <
      if %timeToCheckH% LSS %h2% (
        set checkResult=true
      )
      
      rem ==
      if %timeToCheckH% EQU %h2% (
        rem <
        if %timeToCheckM% LSS %m2% (
          set checkResult=true
        )
      )
    )
    
    rem ==
    if %timeToCheckH% EQU %h1% (
      rem >=
      if %timeToCheckM% GEQ %m1% (
        rem <
        if %timeToCheckH% LSS %h2% (
          set checkResult=true
        )
        
        rem ==
        if %timeToCheckH% EQU %h2% (
          rem <
          if %timeToCheckM% LSS %m2% (
            set checkResult=true
          )
        )
      )
    )
  )
)
exit /b 0


:toArj %from% %to% %mask% %archiveName% %arhType% %lengthCount% %arhSize% %action%
rem ======================================================================
rem Помещаем в архив по маске
rem ======================================================================
rem from        - вх каталог
rem to          - исх каталог (для архивов)
rem mask        - маска архивируемых файлов (можно список через #) Пример: *.arj#*.txt
rem archiveName - шаблон имени архива
rem arhType     - тип архива (f440, f550, ...)
rem lengthCount - длина символа счетчика архива
rem arhSize     - кол файлов в архиве
rem action      - действие которое вносится в лог
rem ======================================================================
setlocal enableextensions enabledelayedexpansion
set from=%1&set to=%2&set mask=%3&set archiveName=%4&set arhType=%5&set lengthCount=%6&set arhSize=%7&set action=%8
set mask=%mask:#= %
call :setVariable
set listFiles=%dirLogs%%timeSm%.files
call :getBatchFolder homeFolder
cd /d %from%
dir /b /ON %mask% > %listFiles%
set /a k=-1
for /f "tokens=*" %%J in ('FileCounter.exe %arhType% %dateS% 10 %lengthCount%') do (set countNow=%%J)
for /f "tokens=*" %%I in (%listFiles%) do (
  set /a k+=1
  if "!k!"=="%arhSize%" (
    rem call :saveListArh %to%%archiveName%!countNow!.arj %dirLogs%%archiveName%!countNow!.arj.%timeSn%.list
    set /a k=0
    for /f "tokens=*" %%J in ('FileCounter.exe %arhType% %dateS% 10 %lengthCount%') do (set countNow=%%J)
  )
  call arj.exe m -e %to%%archiveName%!countNow!.arj %from%%%I
  call :writeLog %%I %action% %from% %to% %archiveName%!countNow!.arj
)
rem call :saveListArh %to%%archiveName%!countNow!.arj %dirLogs%%archiveName%!countNow!.arj.%timeSn%.list
if not "%homeFolder:~0,2%"=="\\" (cd /d %homeFolder%)
del %listFiles%
endlocal&exit /b 0


:moveFilesAndSendEmails %from% %to% %mask% %action% %emails% %subject% %html%
rem ======================================================================
rem Перемещаем файл и отправляем email, тело письма - содержимое файла
rem ======================================================================
rem from        - вх каталог
rem to          - исх каталог (для архивов)
rem mask        - маска обрабатываемых файлов
rem action      - событие для лога
rem emails      - список emails для отправки (можно список через #)
rem subject     - тема письма (вместо пробелов - #)
rem ======================================================================
setlocal enableextensions enabledelayedexpansion
set from=%1&set to=%2&set mask=%3&set action=%4&set emails=%5&set subject=%6&set html=%7
set emails=%emails:#=; %
set mask=%mask:#= %
set subject=%subject:#= %
set bccEmails="a.pasenko@crimea.genbank.ru; k.borovikov@crimea.genbank.ru; d.stetsurin@crimea.genbank.ru;"
call :getBatchFolder homeFolder
cd /d %from%
call :setVariable
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON %mask% > %listFiles%
timeout 3
for /f "tokens=*" %%I in (%listFiles%) do (
  if "%html%"=="-html" (
    SwithMail /s /from "user@crimea.genbank.ru" /to "%emails%" /BCC %bccEmails% /u "user" /pass "userPassword" /SSL "True" /HTML "True" /Server "EmailServer" /p "25" /sub "%subject%%%I" /btxt %from:#= %%%I
  ) else (
    SwithMail /s /from "user@crimea.genbank.ru" /to "%emails%" /BCC %bccEmails% /u "user" /pass "userPassword" /SSL "True" /Server "EmailServer" /p "25" /sub "%subject%%%I" /btxt %from:#= %%%I
  )
  call :moveDouble %from% %to% %%I
  call :writeLog %%I %action% %from% %to%
)
if not "%homeFolder:~0,2%"=="\\" (cd /d %homeFolder%)
del %listFiles%
endlocal&exit /b 0


:moveFilesAndSendAttentionEmailsWithAttachment %from% %to% %mask% %action% %emails% %subject% %body%
rem ======================================================================
rem Перемещаем файл и отправляем информационный email с attachment с файлом
rem ======================================================================
call :moveFilesAndSendAttentionEmails %1 %2 %3 %4 %5 %6 %7 -with_att
endlocal&exit /b 0


:moveFilesAndSendAttentionEmails %from% %to% %mask% %action% %emails% %subject% %body% %attachment%
rem ======================================================================
rem Перемещаем файл и отправляем информационный email
rem ======================================================================
rem from        - вх каталог
rem to          - исх каталог (для архивов)
rem mask        - маска обрабатываемых файлов (можно список через #) Пример: *.arj#*.txt
rem action      - событие для лога
rem emails      - список emails для отправки (можно список через #)
rem subject     - тема письма (вместо пробелов - #)
rem body        - тело письма (вместо пробелов - #)
rem attachment  - флаг о добавлении в письмо оригинала файла (-with_att)
rem ======================================================================
setlocal enableextensions enabledelayedexpansion
set from=%1&set to=%2&set mask=%3&set action=%4&set emails=%5&set subject=%6&set body=%7&set attachment=%8
set mask=%mask:#= %
set emails=%emails:#=; %
set subject=%subject:#= %
set body=%body:#= %
set body=%body:$1$="="%
set body=%body:$2$="<"%
set body=%body:$3$=">"%
set bccEmails="a.pasenko@crimea.genbank.ru; k.borovikov@crimea.genbank.ru; d.stetsurin@crimea.genbank.ru;"
call :getBatchFolder homeFolder
cd /d %from:#= %
call :setVariable
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON %mask% > %listFiles%
timeout 3
for /f "tokens=*" %%I in (%listFiles%) do (
  set name=%%I
  call set subject=%%subject:$file_name$=!name!%%
  call set body=%%body:$file_name$=!name!%%
  if not "%attachment%"=="-with_att" (
    SwithMail /s /from "user@crimea.genbank.ru" /to "%emails%" /BCC %bccEmails% /u "user" /pass "userPassword" /SSL "True" /HTML "True" /Server "EmailServer" /p "25" /sub "!subject!" /b "!body!"
  ) else (
    SwithMail /s /from "user@crimea.genbank.ru" /to "%emails%" /BCC %bccEmails% /u "user" /pass "userPassword" /SSL "True" /HTML "True" /Server "EmailServer" /p "25" /sub "!subject!" /b "!body!" /a "%from:#= %!name!"
  )
  call :moveDouble %from% %to% !name!
  call :writeLog %%I %action% %from% %to%
)
if not "%homeFolder:~0,2%"=="\\" (cd /d %homeFolder%)
del %listFiles%
endlocal&exit /b 0


:extractFromRarAndSend %from% %to% %mask% %emails% %subject% %body%
rem ======================================================================
rem Разархивируем файл и отправляем информационный email
rem ======================================================================
rem from        - папка с архивами
rem to          - папка с распаковаными файлами
rem mask        - маска обрабатываемых файлов (можно список через #) Пример: *.arj#*.txt
rem emails      - список emails для отправки (можно список через #)
rem subject     - тема письма (вместо пробелов - #)
rem body        - тело письма (вместо пробелов - #)
rem ======================================================================
setlocal enableextensions enabledelayedexpansion
set tmpFolder=c:\work\fromRar\out\
set from=%1&set to=%2&set mask=%3&set emails=%4&set subject=%5&set body=%6
set mask=%mask:#= %
set emails=%emails:#=; %
set subject=%subject:#= %
set body=%body:#= %
set body=%body:$1$="="%
set body=%body:$2$="<"%
set body=%body:$3$=">"%
set bccEmails="a.pasenko@crimea.genbank.ru"
call :getBatchFolder homeFolder
cd /d %from:#= %
call :setVariable
set listFiles=%dirLogs%%timeSm%.files
dir /b /ON %mask% > %listFiles%
timeout 9
for /f "tokens=*" %%I in (%listFiles%) do (
  set name=%%I
  set nameShort=!name:.rar=!
  call set subject=%%subject:$file_name$=!name!%%
  7z.exe -y e "%from%%name%" * -o"%tmpFolder%!nameShort!"
  for /f "tokens=*" %%J in ('GetFilesName.exe "%tmpFolder%!nameShort!" "^(\d*).pdf$"') do set destinationFolder=%%J
  for /f "tokens=*" %%J in ('GetFilesName.exe "%tmpFolder%!nameShort!" "^OD(\d*).pdf$" allinline') do (set fileList="%%J")
  GetFilesName "%tmpFolder%!nameShort!" "^(\d*).pdf$" > nul
  if errorlevel 1 (set destinationFolder=!nameShort!)
  call set body=%%body:$file_name$=!destinationFolder!%%
  SwithMail /s /from "user@crimea.genbank.ru" /to "%emails%" /BCC %bccEmails% /u "user" /pass "userPassword" /SSL "True" /HTML "True" /Server "EmailServer" /p "25" /sub "!subject!" /b "!body!"
  call :writeLog %name% extract %from% %to%
  mkdir "%to:#= %!destinationFolder!"
  move "%tmpFolder%!nameShort!\*" "%to:#= %!destinationFolder!"
  rem set checkName=!name:ОД=!
  rem if not "!checkName!"=="!name!" (
  rem   report.vbs "%to:#= %!destinationFolder!\" !destinationFolder! %date:~0,2%.%date:~3,2%.%date:~6,4% "!fileList!"
  rem )
  timeout 3
  rd /Q %tmpFolder%!nameShort!
  del %from%!name!
)
if not "%homeFolder:~0,2%"=="\\" (cd /d %homeFolder%)
del %listFiles%&endlocal&exit /b 0


:fromCab %from% %to% %cabFiles% %mask%
rem ======================================================================
rem Извлекаем из cab файлов по маске
rem ======================================================================
rem from        - папка с архивами
rem to          - папка с распаковаными файлами
rem cabFiles    - маска файлов на разархивацию
rem mask        - маска извлекаемых файлов
rem ======================================================================
setlocal
set from=%1&set to=%2&set cabFiles=%3&set mask=%4
set from=%from:#= %
if not exist "%to%" mkdir "%to%"
call :getBatchFolder homeFolder
set listFilesToSend=%homeFolder%listSendReports.txt
cd /d %from%
where /r %from% /q %cabFiles% > nul
if not errorlevel 1 (call 7z.exe -y e %from%%cabFiles% %mask% -o%to%)
if not "%homeFolder:~0,2%"=="\\" (cd /d %homeFolder%)
endlocal&exit /b 0


:EXIT
exit /b