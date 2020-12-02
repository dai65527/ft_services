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
    sed -e s/localhost/$MYSQL_HOST/ /var/lib/nginx/html/config.sample.inc.php \
        > /var/lib/nginx/html/config.inc.php
    chmod 744 /var/lib/nginx/html/config.inc.php
    chown nginx:nginx /var/lib/nginx/html
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

# start telegraf server
(telegraf --config /etc/telegraf.conf) &

tail -f /var/log/nginx/access.log
