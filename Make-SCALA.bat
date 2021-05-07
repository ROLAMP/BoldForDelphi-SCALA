echo off
SET destination="E:\github.com\BoldForDelphi-SCALA"

REM
REM == CREATE SCALA FOLDER ==
REM

IF NOT EXIST %destination% MD %destination%

REM
REM == COPY FLAT STRUCTURE -> SCALA ==
REM

FOR %%G IN (*) DO COPY *.* %destination%\
for /f %%G in ('dir /b /s /a:d Source') DO COPY %%G %destination%\

