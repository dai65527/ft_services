#!/bin/sh

# Start nginx and php-fpm
echo [wordpress] starting...
/usr/bin/mysqld_safe --datadir='/var/lib/mysql'
