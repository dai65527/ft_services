#!/bin/sh

# Start nginx and php-fpm
echo [wordpress] starting...
php-fpm7
nginx

tail -f /var/log/nginx/access.log
