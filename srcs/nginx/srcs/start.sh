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

# initialize ssh
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ## generate host key
    ssh-keygen -A
    ## edit login message
    if [ $LOGIN_TITLE != "" ]; then
        echo $LOGIN_TITLE | figlet > /etc/motd
        echo >> /etc/motd
    fi
    cat /tmp/login_message.txt >> /etc/motd
    echo >> /etc/motd
fi

# add user for ssh connection
if [ ! -d /home/$USER_SSH ]; then
    echo -e "$USER_SSH_PASS\n$USER_SSH_PASS" | adduser $USER_SSH
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

# Start nginx and sshd
nginx
/usr/sbin/sshd

# start telegraf
(telegraf --config /etc/telegraf.conf) &

tail -f /var/log/nginx/access.log
