#!/bin/sh

# If no mysql data directory (means firsttime launch), initialize.
if [ ! -d /run/mysqld ]; then
echo [database] initializing...
DB_SYSPASS=`pwgen 32 1`
    cat << EOF > init.sql
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$DB_ROOTPASS' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'$WP_HOST' identified by '$DB_ROOTPASS' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$DB_ROOTPASS' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${DB_ROOTPASS}') ;
SET PASSWORD FOR 'mariadb.sys'@'localhost'=PASSWORD('${DB_SYSPASS}') ;
DROP DATABASE IF EXISTS test ;
CREATE DATABASE IF NOT EXISTS \`$WP_DBNAME\` CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL ON \`$WP_DBNAME\`.* to '$WP_DBUSER'@'%' IDENTIFIED BY '$WP_DBPASS';
DELETE FROM mysql.user WHERE Password="";
FLUSH PRIVILEGES ;
EOF
    /usr/bin/mysqld --user=mysql --bootstrap < init.sql
    rm -f init.sql
fi

# telegraf conf
sed -i \
    -e s/"# username = \"telegraf\""/"username = \"$INFDB_TELEGRAF_USER\""/ \
    -e s/"# password = \"metricsmetricsmetricsmetrics\""/"password = \"$INFDB_TELEGRAF_PASS\""/ \
    /etc/telegraf.conf

# start telegraf server
(telegraf --config /etc/telegraf.conf) &

/usr/bin/mysqld_safe --datadir='/var/lib/mysql' --plugin-dir=/usr/lib/mariadb/plugin
