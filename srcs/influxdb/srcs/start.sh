#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/22 15:01:36 by dnakano           #+#    #+#              #
#    Updated: 2020/11/22 15:01:36 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# start influxdb server
(/usr/sbin/influxd -config /etc/influxdb.conf) &

# initialize and add users to influxdb
# https://docs.influxdata.com/influxdb/v1.3/query_language/authentication_and_authorization/#set-up-authentication
# if [ ! -d /var/lib/influxdb/data/telegraf ]; then
    sleep 3;
    influx -host 127.0.0.1 -port 8086 \
        -execute "CREATE USER $INFDB_ADMIN_USER WITH PASSWORD '$INFDB_ADMIN_PASS' WITH ALL PRIVILEGES"
    influx -host 127.0.0.1 -port 8086 -username "$INFDB_ADMIN_USER" -password "$INFDB_ADMIN_PASS" \
        -execute "DROP USER admintmp;"
    influx -host 127.0.0.1 -port 8086 -username "$INFDB_ADMIN_USER" -password "$INFDB_ADMIN_PASS" \
        -execute "CREATE DATABASE telegraf;"
    influx -host 127.0.0.1 -port 8086 -username "$INFDB_ADMIN_USER" -password "$INFDB_ADMIN_PASS" \
        -execute "CREATE USER $INFDB_TELEGRAF_USER WITH PASSWORD '$INFDB_TELEGRAF_PASS';"
    influx -host 127.0.0.1 -port 8086 -username "$INFDB_ADMIN_USER" -password "$INFDB_ADMIN_PASS" \
        -execute "CREATE USER $INFDB_GRAFANA_USER WITH PASSWORD '$INFDB_GRAFANA_PASS';"
    influx -host 127.0.0.1 -port 8086 -username "$INFDB_ADMIN_USER" -password "$INFDB_ADMIN_PASS" \
        -execute "GRANT ALL ON telegraf TO $INFDB_TELEGRAF_USER;"
    influx -host 127.0.0.1 -port 8086 -username "$INFDB_ADMIN_USER" -password "$INFDB_ADMIN_PASS" \
        -execute "GRANT ALL ON telegraf TO $INFDB_GRAFANA_USER;"
# fi

# telegraf conf
sed -i \
    -e s/"# username = \"telegraf\""/"username = \"$INFDB_TELEGRAF_USER\""/ \
    -e s/"# password = \"metricsmetricsmetricsmetrics\""/"password = \"$INFDB_TELEGRAF_PASS\""/ \
    /etc/telegraf.conf

# start telegraf server
telegraf --config /etc/telegraf.conf
