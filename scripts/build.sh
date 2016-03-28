#!/bin/sh

DIR=$(cd "$(dirname "$0")"; pwd) 
source $DIR/config.sh
docker build -t=\"$BASE_NAME\" .
