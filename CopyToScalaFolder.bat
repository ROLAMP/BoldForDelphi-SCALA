echo off
SET destination="D:\DEV\GITHUB.com\BoldForDelphi_SCALA"

REM
REM == CREATE SCALA FOLDER ==
REM

IF NOT EXIST %destination% MD %destination%

REM
REM == COPY FLAT STRUCTURE -> SCALA ==
REM

FOR %%G IN (*) DO COPY *.* %destination%\
for /f %%G in ('dir /b /s /a:d Source') DO COPY %%G %destination%\

