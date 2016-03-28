#!/bin/sh

DIR=$(cd "$(dirname "$0")"; pwd) 
source $DIR/config.sh

#docker stop $BASE_NAME

#( useradd dev >/dev/null ) && ( ssh-keygen -t rsa -C "dev.work" )

#docker ps | grep centos6 | awk '{print $1}' | xargs  docker inspect --format='{{.NetworkSettings.IPAddress}}'
IP_ADDRESS=`docker ps | grep $BASE_NAME | awk '{print $1}' | xargs  docker inspect --format='{{.NetworkSettings.IPAddress}}'`


echo $IP_ADDRESS

exit 0