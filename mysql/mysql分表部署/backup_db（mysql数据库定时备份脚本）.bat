rem *******************************Code Start*****************************
@echo off
set "Ymd=%date:~,4%%date:~5,2%%date:~8,2%"
"D:\Program Files\MySQL\MySQL Server 5.0\bin\mysqldump" --opt -uroot -pzwroot plan > D:\db_backup\plan_%Ymd%.sql
@echo on
rem *******************************Code End*****************************
