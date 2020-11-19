#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/19 15:11:58 by dnakano           #+#    #+#              #
#    Updated: 2020/11/19 15:11:58 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# initialize ssl-config
if [ ! -d /etc/vsftpd/ssl ]; then
    mkdir /etc/vsftpd/ssl
    openssl req -newkey rsa:2048 \
                -sha256 \
                -x509 \
                -days 3650 \
                -nodes \
                -out /etc/vsftpd/ssl/server.crt \
                -keyout /etc/vsftpd/ssl/server.key \
                -subj "/C=JP/ST=Tokyo/L=Minato-ku/O=42tokyo/OU=Student/CN=localhost"
fi

# add user for test connection
if [ ! -d /home/$FTP_USER ]; then
    echo -e "$FTP_USER_PASS\n$FTP_USER_PASS" | adduser $FTP_USER
fi

# start vsftpd (ftps server)
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

tail -f /var/log/vsftpd.log
