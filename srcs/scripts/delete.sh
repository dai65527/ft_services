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

# clean up kubernetes clusters
kubectl delete -f ../wordpress/manifest
kubectl delete -f ../phpmyadmin/manifest
kubectl delete -f ../nginx/manifest
kubectl delete -f ../mysql/manifest
kubectl delete -f ../ftps/manifest
kubectl delete -f ../influxdb/manifest
kubectl delete -f ../grafana/manifest
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl delete secret ft-services-secret
