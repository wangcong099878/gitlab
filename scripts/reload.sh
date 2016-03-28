#!/bin/sh

DIR=$(cd "$(dirname "$0")"; pwd) 
source $DIR/config.sh
docker restart $BASE_NAME 

exit 0

