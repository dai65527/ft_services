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
    if [ $SSH_LOGINTITLE != "" ]; then
        echo $SSH_LOGINTITLE | figlet > /etc/motd
        echo >> /etc/motd
    fi
    cat /tmp/login_message.txt >> /etc/motd
    echo >> /etc/motd
fi

# add user for ssh connection
if [ ! -d /home/$SSHUSER ]; then
    echo -e "$SSHUSER_PASS\n$SSHUSER_PASS" | adduser $SSHUSER
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

# telegraf conf
sed -i \
    -e s/"# username = \"telegraf\""/"username = \"$INFDB_TELEGRAF_USER\""/ \
    -e s/"# password = \"metricsmetricsmetricsmetrics\""/"password = \"$INFDB_TELEGRAF_PASS\""/ \
    /etc/telegraf.conf

# Start nginx and sshd
nginx
/usr/sbin/sshd

# start telegraf
(telegraf --config /etc/telegraf.conf) &

tail -f /var/log/nginx/access.log
