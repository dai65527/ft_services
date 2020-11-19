# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/17 18:59:04 by dnakano           #+#    #+#              #
#    Updated: 2020/11/19 09:10:04 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# use alpine as baseimage
FROM    alpine:latest

# setting of database for wordpress (used to make wp-config.php in start.sh)
ENV     WP_DBNAME wordpress
ENV     WP_DBUSER wpdbuser
ENV     WP_DBPASS wpdbpass
ENV     WP_DBHOST mysql

# install nginx and openssl
RUN     apk update && apk add --no-cache \
                vim \
                nginx \
                openssl

# setup ssl
RUN     mkdir /etc/nginx/ssl \
        && openssl req -newkey rsa:2048 \
                       -x509 \
                       -sha256 \
                       -days 3650 \
                       -nodes \
                       -out /etc/nginx/ssl/server.crt \
                       -keyout /etc/nginx/ssl/server.key \
                       -subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42tokyo/OU=Student/CN=localhost"

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
                php7-dom

# copy wordpress sources to page root
RUN     rm -rf /var/lib/nginx/html
COPY    ./srcs/wordpress_srcs /var/lib/nginx/html

# settings for nginx and php
RUN     mkdir -p /run/nginx
RUN     mkdir /run/php-fpm
COPY    ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY    ./srcs/www.conf /etc/php7/php-fpm.d/www.conf

# set start.sh
COPY    ./srcs/start.sh /start.sh
RUN     chmod 744 /start.sh

CMD     [ "/start.sh" ]
