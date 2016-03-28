#!/bin/sh

DIR=$(cd "$(dirname "$0")"; pwd) 
source $DIR/config.sh
docker stop $BASE_NAME
docker rm $BASE_NAME

