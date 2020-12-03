#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    fclean.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/03 08:09:25 by dnakano           #+#    #+#              #
#    Updated: 2020/12/03 08:09:25 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# delete k8s manifest
./delete.sh

# remove docker image
docker rmi ft_services/wordpress
docker rmi ft_services/phpmyadmin
docker rmi ft_services/nginx
docker rmi ft_services/mysql
docker rmi ft_services/ftps
docker rmi ft_services/grafana
docker rmi ft_services/influxdb
