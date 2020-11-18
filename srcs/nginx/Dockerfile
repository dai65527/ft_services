# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/17 18:59:04 by dnakano           #+#    #+#              #
#    Updated: 2020/11/17 19:57:55 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# use alpine as baseimage
FROM    alpine:latest

# install nginx and openssl
RUN     apk update && apk add --no-cache \
        vim \
        nginx \
        openssl

RUN     mkdir /etc/nginx/ssl \
        && openssl req -newkey rsa:2048 \
                       -x509 \
                       -sha256 \
                       -days 3650 \
                       -nodes \
                       -out /etc/nginx/ssl/server.crt \
                       -keyout /etc/nginx/ssl/server.key \
                       -subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42tokyo/OU=Student/CN=localhost"

RUN     mkdir -p /run/nginx
COPY    ./srcs/default.conf /etc/nginx/conf.d/default.conf

CMD     [ "sh" ]
