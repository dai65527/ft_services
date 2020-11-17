#!/bin/sh

# If no mysql data directory (means firsttime launch), initialize.
if [ ! -d /run/mysqld ]; then
echo [database] initializing...
    cat << EOF > init.sql
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF
    /usr/bin/mysqld --user=mysql --bootstrap < init.sql
    rm init.sql
fi

echo [database] starting...
/usr/bin/mysqld_safe --datadir='/var/lib/mysql'
