# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/22 13:42:21 by dnakano           #+#    #+#              #
#    Updated: 2020/12/02 19:34:16 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM    alpine:latest

# env vars for config
ENV     INFDB_GRAFANA_USER grafana
ENV     INFDB_GRAFANA_PASS grafanapass
ENV     INFDB_TELEGRAF_USER telegraf
ENV     INFDB_TELEGRAF_PASS telegrafpass

# install grafana
RUN     echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
            >> /etc/apk/repositories \
        && apk update && apk add --no-cache \
            grafana@testing \
            openssl \
# install telegraf to store metrix data to influxdb
            telegraf@testing

# grafana config
RUN     sed -i \
            -e s/";data = \/var\/lib\/grafana"/"data = \/var\/lib\/grafana"/ \
            -e s/";log = \/var\/log\/grafana"/"log = \/var\/log\/grafana"/ \
            -e s/";plugins = \/var\/lib\/grafana\/plugins"/"plugins = \/var\/lib\/grafana\/plugins"/ \
            -e s/";provisioning = conf\/provisioning"/"provisioning = conf\/provisioning"/ \
            -e s/";cert_file ="/"cert_file = \/etc\/grafana\/ssl\/server.crt"/ \
            -e s/";cert_key ="/"cert_key = \/etc\/grafana\/ssl\/server.key"/ \
            -e s/";protocol = http"/"protocol = https"/ \
            /etc/grafana.ini

# add grafana provisioning
# https://grafana.com/docs/grafana/latest/administration/provisioning/
COPY    ./srcs/provisioning/datasource.yml /usr/share/grafana/conf/provisioning/datasources
COPY    ./srcs/provisioning/dashboards /usr/share/grafana/conf/provisioning/dashboards

# telegraf config
RUN     sed -i \
            -e s/'hostname = ""'/'hostname = "grafana"'/ \
            -e s/'# database = "telegraf"'/'database = "telegraf"'/ \
            -e s/'# urls = \["http:\/\/127.0.0.1:8086"\]'/'urls = \["http:\/\/influxdb:8086"\]'/ \
            /etc/telegraf.conf

# set start.sh
COPY    ./srcs/start.sh /start.sh
RUN     chmod 744 /start.sh

ENTRYPOINT [ "/start.sh" ]
