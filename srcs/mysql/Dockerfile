# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/18 15:29:06 by dnakano           #+#    #+#              #
#    Updated: 2020/11/18 17:43:25 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM    alpine:latest

# default password for root user and sys
ENV     DB_ROOTPASS=rootpass

# database and user for wordpress
ENV     WP_DBNAME wordpress
ENV     WP_DBUSER wpdbuser
ENV     WP_DBPASS wpdbpass
ENV     WP_DBHOST localhost

# Install MariaDB (alternative to MySQL)
# RUN     apk --no-cache add mariadb
RUN     apk --no-cache add mariadb \
                           mariadb-client \
                           pwgen

# Initialize database
RUN     /usr/bin/mysql_install_db --user=mysql \
                                  --datadir=/var/lib/mysql \
                                  --auth-root-authentication-method=normal

COPY    ./srcs/start.sh /
RUN     chmod 755 /start.sh

CMD     [ "/start.sh" ]
