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

# grafana config

# telegraf conf
sed -i \
    -e s/"# username = \"telegraf\""/"username = \"$INFDB_TELEGRAF_USER\""/ \
    -e s/"# password = \"metricsmetricsmetricsmetrics\""/"password = \"$INFDB_TELEGRAF_PASS\""/ \
    /etc/telegraf.conf

# start telegraf server
(telegraf --config /etc/telegraf.conf) &

# start grafana server
/usr/sbin/grafana-server -config /etc/grafana.ini -homepath /usr/share/grafana
