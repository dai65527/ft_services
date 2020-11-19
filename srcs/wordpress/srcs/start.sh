#!/bin/sh

if [ ! -f /var/lib/nginx/html/wp-config.php ]; then
    echo [wordpress] initializing...
    sed -e s/database_name_here/$WP_DBNAME/ \
        -e s/username_here/$WP_DBUSER/ \
        -e s/password_here/$WP_DBPASS/ \
        -e s/localhost/$WP_DBHOST/ \
        /var/lib/nginx/html/wp-config-sample.php \
        > /var/lib/nginx/html/wp-config.php
fi

# Start nginx and php-fpm
echo [wordpress] starting...
php-fpm7
nginx

tail -f /var/log/nginx/access.log
