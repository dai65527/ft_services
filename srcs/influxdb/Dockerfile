# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/22 11:55:38 by dnakano           #+#    #+#              #
#    Updated: 2020/12/22 17:19:38 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM    alpine:latest

ENV     INFDB_ADMIN_USER admin
ENV     INFDB_ADMIN_PASS adminpass
ENV     INFDB_TELEGRAF_USER telegraf
ENV     INFDB_TELEGRAF_PASS telegrafpass
ENV     INFDB_GRAFANA_USER grafana
ENV     INFDB_GRAFANA_PASS grafanapass

# install influxdb
RUN     echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" \
            >> /etc/apk/repositories \
        && apk update && apk add --no-cache \
            influxdb \
# install telegraf to store metrix data to influxdb
            telegraf@community

# influxdb config
## add default admin user
# RUN     (/usr/sbin/influxd -config /etc/influxdb.conf) & \
#         sleep 5 \
#         && influx -host 127.0.0.1 -port 8086 \
#             -execute "CREATE USER admintmp WITH PASSWORD 'admintmppass' WITH ALL PRIVILEGES"

RUN     sed -i \
            -e s/"# auth-enabled = false"/"auth-enabled = true"/ \
            /etc/influxdb.conf

# telegraf config
RUN     sed -i \
            -e s/'hostname = ""'/'hostname = "influxdb"'/ \
            -e s/'# database = "telegraf"'/'database = "telegraf"'/ \
            -e s/'# urls = \["http:\/\/127.0.0.1:8086"\]'/'urls = \["http:\/\/localhost:8086"\]'/ \
            /etc/telegraf.conf

# set start.sh
COPY    ./srcs/start.sh /start.sh
RUN     chmod 744 /start.sh

ENTRYPOINT [ "/start.sh" ]
