# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/17 18:59:04 by dnakano           #+#    #+#              #
#    Updated: 2020/12/22 17:19:41 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# use alpine as baseimage
FROM    alpine:latest

# env
ENV     SSHUSER user42
ENV     SSHUSER_PASS user42
ENV     SSH_LOGINTITLE FT_SERVICES

# user and pass of influxdb for telegraf
ENV     INFDB_TELEGRAF_USER telegraf
ENV     INFDB_TELEGRAF_PASS telegrafpass

# install nginx, openssl and openssh (and figlet haha)
RUN     echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" \
            >> /etc/apk/repositories \
        && apk update && apk add --no-cache \
            nginx \
            openssl \
            openssh \
            figlet \
# install telegraf to store metrix data to influxdb
            telegraf@community

# configure of nginx
RUN     mkdir -p /run/nginx
COPY    ./srcs/default.conf /etc/nginx/conf.d/default.conf

# add index.html
RUN     rm -f /var/lib/nginx/html/*index*.html
COPY    ./srcs/index.html /var/lib/nginx/html/index.html
RUN     chown -R nginx:nginx /var/lib/nginx/html

# cofigure of lftp
# allowing lftp to ignore self signed certificate 
# (just for test. should be removed for practical use)
RUN     echo "set ssl:verify-certificate no" >> /etc/lftp.conf

# configure of telegraf
RUN     sed -i \
            -e s/'hostname = ""'/'hostname = "nginx"'/ \
            -e s/'# urls = \["http:\/\/127.0.0.1:8086"\]'/'urls = \["http:\/\/influxdb:8086"\]'/ \
            /etc/telegraf.conf

# set start.sh
COPY    ./srcs/start.sh /start.sh
RUN     chmod 744 /start.sh

# set liveness.sh
COPY    ./srcs/liveness.sh /liveness.sh
RUN     chmod 744 /liveness.sh

# copy login message
COPY    ./srcs/login_message.txt /tmp

ENTRYPOINT [ "/start.sh" ]
