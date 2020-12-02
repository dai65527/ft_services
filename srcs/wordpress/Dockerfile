# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/17 18:59:04 by dnakano           #+#    #+#              #
#    Updated: 2020/12/03 01:46:36 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# use alpine as baseimage
FROM    alpine:latest

# setting of database for wordpress (used to make wp-config.php in start.sh)
ENV     MYSQL_HOST mysql
ENV     WP_MYSQLDBNAME wordpress
ENV     WP_MYSQLUSER wpdbuser
ENV     WP_MYSQLPASS wpdbpass

# wordpress users, mailadress and passwords
ENV     WP_ADMIN_NAME admin
ENV     WP_ADMIN_PASS admin
ENV     WP_ADMIN_EMAIL admin@admin.com
ENV     WP_USER1_NAME user1
ENV     WP_USER1_PASS user1
ENV     WP_USER1_EMAIL user1@user1.com
ENV     WP_USER2_NAME user2
ENV     WP_USER2_PASS user2
ENV     WP_USER2_EMAIL user2@user2.com

# user and pass of influxdb for telegraf
ENV     INFDB_TELEGRAF_USER telegraf
ENV     INFDB_TELEGRAF_PASS telegrafpass

# install nginx and openssl
RUN     echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
            >> /etc/apk/repositories \
        && apk update && apk add --no-cache \
            nginx \
            openssl \
# install telegraf to store metrix data to influxdb
            telegraf@testing

# install php and extension package needed by wordpress
RUN     apk add --no-cache \
                php7 \
                php7-fpm \
                php7-common \
                php7-iconv \
                php7-json \
                php7-gd \
                php7-curl \
                php7-xml \
                php7-mysqli \
                php7-imap \
                php7-cgi \
                fcgi \
                php7-pdo \
                php7-pdo_mysql \
                php7-soap \
                php7-xmlrpc \
                php7-posix \
                php7-mcrypt \
                php7-gettext \
                php7-ldap \
                php7-ctype \
                php7-dom \
                php7-phar

# install wp-cli
# https://wp-cli.org/ja/
RUN     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
        && chmod 755 wp-cli.phar \
        && mv wp-cli.phar /usr/local/bin/wp

# telegraf config
RUN     sed -i \
            -e s/'hostname = ""'/'hostname = "wordpress"'/ \
            -e s/'# database = "telegraf"'/'database = "telegraf"'/ \
            -e s/'# urls = \["http:\/\/127.0.0.1:8086"\]'/'urls = \["http:\/\/influxdb:8086"\]'/ \
            /etc/telegraf.conf

# copy wordpress sources to page root
RUN     rm -rf /var/lib/nginx/html
COPY    ./srcs/wordpress_srcs /var/lib/nginx/html
RUN     mkdir /var/lib/nginx/html/health \
        && echo '<?php phpinfo(); ?>' > /var/lib/nginx/html/health/index.php \
        && chown -R nginx:nginx /var/lib/nginx/html

# settings for nginx and php
RUN     mkdir -p /run/nginx
RUN     mkdir /run/php-fpm
COPY    ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY    ./srcs/www.conf /etc/php7/php-fpm.d/www.conf

# set start.sh
COPY    ./srcs/start.sh /start.sh
RUN     chmod 744 /start.sh

ENTRYPOINT [ "/start.sh" ]
