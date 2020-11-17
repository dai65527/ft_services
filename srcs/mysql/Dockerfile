FROM    alpine:latest

# default password for root user
ENV     MYSQL_ROOT_PASSWORD=rootpass

# Install MariaDB (alternative to MySQL)
RUN     apk --no-cache add mariadb
# RUN     apk --no-cache add mariadb mariadb-client

# Initialize database
RUN     /usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal
COPY    ./srcs/start.sh /
RUN     chmod 755 /start.sh

CMD     [ "/start.sh" ]
