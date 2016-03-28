#!/bin/sh

DIR=$(cd "$(dirname "$0")"; pwd) 
source $DIR/config.sh

#echo $IMAGE_NAME
#exit 0

docker stop $BASE_NAME

