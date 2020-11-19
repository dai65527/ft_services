#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/19 16:51:08 by dnakano           #+#    #+#              #
#    Updated: 2020/11/19 16:51:08 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if [ ! -f /var/lib/nginx/html/config.inc.php ]; then
    sed -e s/localhost/$DBHOST/ /var/lib/nginx/html/config.sample.inc.php \
        > /var/lib/nginx/html/config.inc.php
    chmod 744 /var/lib/nginx/html/config.inc.php
    chown nginx:nginx /var/lib/nginx/html
fi

# Start nginx and php-fpm
echo [phpmyadmin] starting...
php-fpm7
nginx

tail -f /var/log/nginx/access.log
