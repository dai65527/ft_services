#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    liveness.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dnakano <dnakano@student.42tokyo.jp>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/02 16:25:32 by dnakano           #+#    #+#              #
#    Updated: 2020/12/02 16:25:32 by dnakano          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

wget --spider --no-check-certificate https://localhost
RETURN_NGINX=$?
nc -vzw 1 127.0.0.1 22
RETURN_SSHD=$?
if [ $RETURN_NGINX = 0 ] && [ $RETURN_SSHD = 0 ]; then
	exit 0
else
	exit 1
fi

