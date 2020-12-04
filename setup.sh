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

# start minikube
sudo minikube start --driver=none

# change owner of ~/.kube
sudo chown -R $USER:$USER ~/.kube
sudo chown -R $USER:$USER ~/.minikube

# build docker image
## build each containers
docker build -t ft_services/wordpress ./srcs/wordpress
docker build -t ft_services/phpmyadmin ./srcs/phpmyadmin
docker build -t ft_services/nginx ./srcs/nginx
docker build -t ft_services/mysql ./srcs/mysql
docker build -t ft_services/ftps ./srcs/ftps
docker build -t ft_services/grafana ./srcs/grafana
docker build -t ft_services/influxdb ./srcs/influxdb

# setup metallb (https://metallb.universe.tf/installation/)
## enable strict ARP mode (needed)
### display what would be changed
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" \
    -e s/'mode: ""'/'mode: "ipvs"'/ | \
kubectl diff -f - -n kube-system
### apply change
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" \
    -e s/'mode: ""'/'mode: "ipvs"'/ | \
kubectl apply -f - -n kube-system
### install metallb by manifest 
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
### (On first install only)
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# create secret for ft_services
kubectl create secret generic ft-services-secret --from-env-file=./srcs/env/ft_services.env-file

# apply kubernetes manifests
./srcs/scripts/apply.sh

# start dashboard
sudo minikube dashboard
