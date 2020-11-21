#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    apply.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/21 09:42:24 by dnakano           #+#    #+#              #
#    Updated: 2020/11/21 09:42:24 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# apply k8s manifest of ft_services container
kubectl apply -f srcs/metallb/metallb-config.yml
kubectl apply -f ./srcs/wordpress/manifest
kubectl apply -f ./srcs/phpmyadmin/manifest
kubectl apply -f ./srcs/nginx/manifest
kubectl apply -f ./srcs/mysql/manifest
kubectl apply -f ./srcs/ftps/manifest

# kubectl apply -f srcs/metallb/metallb-config.yml -n metallb-system
# kubectl apply -f ./srcs/wordpress/manifest -n metallb-system
# kubectl apply -f ./srcs/phpmyadmin/manifest -n metallb-system
# kubectl apply -f ./srcs/nginx/manifest -n metallb-system
# kubectl apply -f ./srcs/mysql/manifest -n metallb-system
# kubectl apply -f ./srcs/ftps/manifest -n metallb-system