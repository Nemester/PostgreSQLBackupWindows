@echo off

SET PGPASSWORD=[PW]
SET db_name=[dbname]
SET file_format=c
SET host_name=[dbserver]
SET user_name=[user]
SET pg_dump_path="C:\Program Files\PostgreSQL\11\bin\pg_dump.exe"
SET target_backup_path=D:\BACKUP\
SET other_pg_dump_flags=--blobs --verbose -c

for /f "tokens=1-3 delims=- " %%i in ("%date%") do (
	set month=%%j
	set day=%%i
	set year=%%k
)
for /f "tokens=1-3 delims=: " %%i in ("%time%") do (
	set hour=%%i
	set min=%%j
	set sec=%%k
)


for /f "delims=" %%i in ('dir "%target_backup_path%" /b/a-d ^| find /v /c "::"') do set count=%%i
set /a count=%count%+1
set datestr=backup_%year%_%month%_%day%_%hour%_%min%

set BACKUP_FILE=%db_name%_%datestr%.backup

%pg_dump_path% --host=%host_name% -U %user_name% --format=%file_format%  %other_pg_dump_flags% -f %target_backup_path%%BACKUP_FILE%  %db_name%
