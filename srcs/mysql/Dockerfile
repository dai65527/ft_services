# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/18 15:29:06 by dnakano           #+#    #+#              #
#    Updated: 2020/11/23 15:33:13 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM    alpine:latest

# default password for root user and sys
ENV     DB_ROOTPASS=rootpass

# database and user for wordpress
ENV     WP_DBNAME wordpress
ENV     WP_DBUSER wpdbuser
ENV     WP_DBPASS wpdbpass

# Install MariaDB (alternative to MySQL)
RUN     echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
            >> /etc/apk/repositories \
        && apk update && apk add --no-cache \
            mariadb \
            mariadb-client \
            pwgen \
# install telegraf to store metrix data to influxdb
            telegraf@testing

# mysql config
RUN     /usr/bin/mysql_install_db --user=mysql \
                                  --datadir=/var/lib/mysql \
                                  --auth-root-authentication-method=normal \
        && sed -i -e s/skip-networking/"# skip-networking"/ \
        /etc/my.cnf.d/mariadb-server.cnf 

# telegraf config
RUN     sed -i \
            -e s/'hostname = ""'/'hostname = "mysql"'/ \
            -e s/'# urls = \["http:\/\/127.0.0.1:8086"\]'/'urls = \["http:\/\/influxdb:8086"\]'/ \
            /etc/telegraf.conf

COPY    ./srcs/start.sh /
RUN     chmod 755 /start.sh

CMD     [ "/start.sh" ]
