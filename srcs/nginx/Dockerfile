# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/17 18:59:04 by dnakano           #+#    #+#              #
#    Updated: 2020/11/20 07:55:59 by dnakano          ###   ########.fr        #
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
        figlet \
## install lftp for check ftps
        lftp

# configure of nginx
RUN     mkdir -p /run/nginx
COPY    ./srcs/default.conf /etc/nginx/conf.d/default.conf

# cofigure of lftp
# allowing lftp to ignore self signed certificate 
# (just for test. should be removed for practical use)
RUN     echo "set ssl:verify-certificate no" >> /etc/lftp.conf

# set start.sh
COPY    ./srcs/start.sh /start.sh
RUN     chmod 744 /start.sh

# copy login message
COPY    ./srcs/login_message.txt /tmp

CMD     [ "/start.sh" ]
