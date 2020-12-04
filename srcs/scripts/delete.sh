#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    delete.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/21 09:43:27 by dnakano           #+#    #+#              #
#    Updated: 2020/12/02 09:43:27 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if [ ! -d ./srcs/scripts ]; then
    echo "this scripts must be executed from ROOT of the REPOSITORY!!"
    return 1
fi

# clean up kubernetes clusters
kubectl delete -f ./srcs/wordpress/manifest
kubectl delete -f ./srcs/phpmyadmin/manifest
kubectl delete -f ./srcs/nginx/manifest
kubectl delete -f ./srcs/mysql/manifest
kubectl delete -f ./srcs/ftps/manifest
kubectl delete -f ./srcs/influxdb/manifest
kubectl delete -f ./srcs/grafana/manifest
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl delete secret ft-services-secret
