#!/bin/zsh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/20 18:57:41 by dnakano           #+#    #+#              #
#    Updated: 2020/11/20 18:57:41 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# build docker image
## build to minikube env
eval $(minikube docker-env)
## build each containers
docker build -t ft_services/wordpress ./srcs/wordpress
docker build -t ft_services/phpmyadmin ./srcs/phpmyadmin
docker build -t ft_services/nginx ./srcs/nginx
docker build -t ft_services/mysql ./srcs/mysql
docker build -t ft_services/ftps ./srcs/ftps

# apply kubernetes manifest

