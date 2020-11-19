# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/17 18:59:04 by dnakano           #+#    #+#              #
#    Updated: 2020/11/19 16:47:19 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# use alpine as baseimage
FROM    alpine:latest

# env
ENV     USER_SSH user42
ENV     USER_SSH_PASS user42
ENV     LOGIN_TITLE FT_SERVICES

# install nginx, openssl and openssh (and figlet haha)
RUN     apk update && apk add --no-cache \
        nginx \
        openssl \
        openssh \
        figlet

# setting for nginx
RUN     mkdir -p /run/nginx
COPY    ./srcs/default.conf /etc/nginx/conf.d/default.conf

# set start.sh
COPY    ./srcs/start.sh /start.sh
RUN     chmod 744 /start.sh

# copy login message
COPY    ./srcs/login_message.txt /tmp

CMD     [ "/start.sh" ]
# CMD     [ "sh" ]
