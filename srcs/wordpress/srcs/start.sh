#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/25 18:33:16 by dnakano           #+#    #+#              #
#    Updated: 2020/11/25 18:33:16 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if [ ! -f /var/lib/nginx/html/wp-config.php ]; then
    sed -e s/database_name_here/$WP_MYSQLDBNAME/ \
        -e s/username_here/$WP_MYSQLUSER/ \
        -e s/password_here/$WP_MYSQLPASS/ \
        -e s/localhost/$MYSQL_HOST/ \
        /var/lib/nginx/html/wp-config-sample.php \
        > /var/lib/nginx/html/wp-config.php
fi

# initialize ssl-config
if [ ! -d /etc/nginx/ssl ]; then
    mkdir /etc/nginx/ssl
    openssl req -newkey rsa:2048 \
                -sha256 \
                -x509 \
                -days 3650 \
                -nodes \
                -out /etc/nginx/ssl/server.crt \
                -keyout /etc/nginx/ssl/server.key \
                -subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42tokyo/OU=Student/CN=localhost"
fi

# telegraf conf
sed -i \
    -e s/"# username = \"telegraf\""/"username = \"$INFDB_TELEGRAF_USER\""/ \
    -e s/"# password = \"metricsmetricsmetricsmetrics\""/"password = \"$INFDB_TELEGRAF_PASS\""/ \
    /etc/telegraf.conf

# Start nginx and php-fpm
php-fpm7
nginx

# Install wordpress with 1 admin user and 2 normal users
sleep 10
wp core install --url=https://192.168.1.200:5050 --title=test --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASS --admin_email="$WP_ADMIN_EMAIL" --allow-root --path=/var/lib/nginx/html
wp user create $WP_USER1_NAME $WP_USER1_EMAIL --role=editor --user_pass="$WP_USER1_PASS" --allow-root --path=/var/lib/nginx/html
wp user create $WP_USER2_NAME $WP_USER2_EMAIL --role=editor --user_pass="$WP_USER2_PASS" --allow-root --path=/var/lib/nginx/html

# start telegraf server
(telegraf --config /etc/telegraf.conf) &

tail -f /var/log/nginx/access.log
