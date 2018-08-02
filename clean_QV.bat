@echo off

setlocal
cd /d %~dp0

del finalList.txt 

set mypath=%cd%
set num_Months=%~1
set /a num_Days=%num_Months%*30

set ROOT_FOLDER=D:\RfoDiscovery\MAQVROOT
set MAUI_ID=MAUI_376E12A799769D36E0532DAE140A332
set schema=RAY_PRA_401
set password=XOnW3PeOFN/7KWeSAFe4DQ==
set DB=BCRSTES1


set log_file=%mypath%\purge_log

QVDecrypt.exe %password%>tmp.log

for /F "tokens=*" %%A in (tmp.log) do (set decryptpw="%%A")

del tmp.log

cmd /C echo exit | sqlplus -L %schema%/%decryptpw%@%DB% @get_pks.sql %num_Months%

TYPE pk_list.txt>>finalList.txt 


for /F "tokens=*" %%A in (pk_list.txt) do (GetQVHash.exe %%A >>finalList.txt )


SET full_maqv=%ROOT_FOLDER%\MAQV\%MAUI_ID%\
SET full_server=%ROOT_FOLDER%\SERVER\MAQV\%MAUI_ID%\

SETLOCAL ENABLEDELAYEDEXPANSION

forfiles -p "!full_maqv!ADM\extractor" -s -m *.log /D -!num_Days! /C "cmd /c del @path"
forfiles -p "!full_maqv!BIII\extractor" -s -m *.log /D -!num_Days! /C "cmd /c del @path"
forfiles -p "!full_maqv!FDM\extractor" -s -m *.log /D -!num_Days! /C "cmd /c del @path"
forfiles -p "!full_maqv!RR\extractor" -s -m *.log /D -!num_Days! /C "cmd /c del @path"


FOR /R %full_maqv% %%G in (.) DO (
Pushd %%G
  set "result=%%G"
echo %%G
if "!result!"=="!result:BCRS=!" (for /F "tokens=*" %%A  in (!mypath!\finalList.txt) do  (del *%%A*)) 
 Popd )
REM for /F "tokens=*" %%A  in (finalList.txt) do (DEL *%%A.QV*)

echo Now deleting files in Server folder 

FOR /R %full_server% %%G in (.) DO (
Pushd %%G
  set "result=%%G"
echo %%G
if "!result!"=="!result:BCRS=!" (for /F "tokens=*" %%A  in (!mypath!\finalList.txt) do  (del *%%A*)) 
 Popd )

ECHO OFF 
 
if %errorlevel%==0 echo success
if NOT %errorlevel%==0 echo success

pause.
rem Exit /b %errorlevel%
