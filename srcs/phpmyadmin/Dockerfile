# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/17 18:59:04 by dnakano           #+#    #+#              #
#    Updated: 2020/11/23 15:36:02 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# use alpine as baseimage
FROM    alpine:latest

# setting of database for phpmyadmin
ENV     DBHOST mysql

# install nginx and openssl
RUN     apk update && apk add --no-cache \
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
                php7-session \
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
                php7-dom 

# download and install phpmyadmin
RUN     rm -r /var/lib/nginx/html/* \
        && wget -P /tmp https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz \
        && tar xvf /tmp/phpMyAdmin-5.0.4-all-languages.tar.gz --strip-components=1 -C /var/lib/nginx/html \
        && chown -R nginx:nginx /var/lib/nginx/html \
        && rm -f /tmp/phpMyAdmin-5.0.4-all-languages.tar.gz

# telegraf config
RUN     sed -i \
            -e s/'hostname = ""'/'hostname = "phpmyadmin"'/ \
            -e s/'# urls = \["http:\/\/127.0.0.1:8086"\]'/'urls = \["http:\/\/influxdb:8086"\]'/ \
            /etc/telegraf.conf

# settings for nginx and php
RUN     mkdir -p /run/nginx \
        && mkdir /run/php-fpm
COPY    ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY    ./srcs/www.conf /etc/php7/php-fpm.d/www.conf

# set start.sh
COPY    ./srcs/start.sh /start.sh
RUN     chmod 744 /start.sh

CMD     [ "/start.sh" ]
