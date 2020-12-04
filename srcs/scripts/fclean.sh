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

###
# this scripts must be executed from root of the REPOSITORY!!
###

# delete k8s manifest
./srcs/scripts/delete.sh 2> /dev/null
if [ $? -ne 0 ]; then
    echo "this scripts must be executed from ROOT of the REPOSITORY!!"
    return 1
fi

# remove docker image
docker rmi ft_services/wordpress
docker rmi ft_services/phpmyadmin
docker rmi ft_services/nginx
docker rmi ft_services/mysql
docker rmi ft_services/ftps
docker rmi ft_services/grafana
docker rmi ft_services/influxdb
