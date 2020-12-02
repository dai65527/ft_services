# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/19 17:55:57 by dnakano           #+#    #+#              #
#    Updated: 2020/12/02 19:27:55 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# use alpine as baseimage
FROM    alpine:latest

# ftpuser
ENV     FTP_USER user42
ENV     FTP_USER_PASS user42

# user and pass of influxdb for telegraf
ENV     INFDB_TELEGRAF_USER telegraf
ENV     INFDB_TELEGRAF_PASS telegrafpass

# install openssl
RUN     echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
            >> /etc/apk/repositories \
        && apk update && apk add --no-cache \
            vsftpd \
            openssl \
# install telegraf to store metrix data to influxdb
            telegraf@testing

# ftpd config
# http://park12.wakwak.com/~eslab/pcmemo/linux/vsftpd/vsftpd2.html
RUN     sed -i \
            -e s/"anonymous_enable=YES"/"anonymous_enable=NO"/ \
            -e s/"#local_enable=YES"/"local_enable=YES"/ \
            -e s/"#write_enable=YES"/"write_enable=YES"/ \
            /etc/vsftpd/vsftpd.conf \
        && echo seccomp_sandbox=NO >> /etc/vsftpd/vsftpd.conf \
        && echo pasv_enable=YES >> /etc/vsftpd/vsftpd.conf \
        && echo pasv_min_port=60000 >> /etc/vsftpd/vsftpd.conf \
        && echo pasv_max_port=60002 >> /etc/vsftpd/vsftpd.conf \
        && echo pasv_promiscuous=YES >> /etc/vsftpd/vsftpd.conf \
        && echo log_ftp_protocol=YES >> /etc/vsftpd/vsftpd.conf \
        && echo debug_ssl=YES >> /etc/vsftpd/vsftpd.conf \
        && echo vsftpd_log_file=/var/log/vsftpd.log >> /etc/vsftpd/vsftpd.conf \
        && echo ssl_enable=YES >> /etc/vsftpd/vsftpd.conf \
        && echo rsa_cert_file=/etc/vsftpd/ssl/server.crt >> /etc/vsftpd/vsftpd.conf \
        && echo rsa_private_key_file=/etc/vsftpd/ssl/server.key >> /etc/vsftpd/vsftpd.conf

# telegraf config
RUN     sed -i \
            -e s/'hostname = ""'/'hostname = "ftps"'/ \
            -e s/'# database = "telegraf"'/'database = "telegraf"'/ \
            -e s/'# urls = \["http:\/\/127.0.0.1:8086"\]'/'urls = \["http:\/\/influxdb:8086"\]'/ \
            /etc/telegraf.conf

# set start.sh
COPY    ./srcs/start.sh /start.sh
RUN     chmod 744 /start.sh

ENTRYPOINT [ "/start.sh" ]
