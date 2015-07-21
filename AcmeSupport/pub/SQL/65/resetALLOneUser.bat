set SHARE_DIR=C:\65

REM drop the old users
REM sqlplus SYSTEM/MANAGE < dropISV6OneUser.sql > logs\dropISV6OneUser.sql.out
sqlplus SYSTEM/MANAGE < createISV6OneUser.sql > logs\createISV6OneUser.sql.out
sqlplus ISV6/ISV6 < create_all_V6.sql > logs\create_all_V6.sql.out0

pause





