# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/18 15:29:06 by dnakano           #+#    #+#              #
#    Updated: 2020/11/19 10:42:14 by dnakano          ###   ########.fr        #
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
# RUN     apk --no-cache add mariadb
RUN     apk --no-cache add mariadb \
                           mariadb-client \
                           pwgen

# Initialize database
RUN     /usr/bin/mysql_install_db --user=mysql \
                                  --datadir=/var/lib/mysql \
                                  --auth-root-authentication-method=normal \
        && sed -i -e s/skip-networking/"# skip-networking"/ \
        /etc/my.cnf.d/mariadb-server.cnf 

COPY    ./srcs/start.sh /
RUN     chmod 755 /start.sh

CMD     [ "/start.sh" ]
