#!/bin/sh

DIR=$(cd "$(dirname "$0")"; pwd) 
source $DIR/config.sh

## create docker-data container if does not exist
( docker ps -a |grep 'docker-data' >/dev/null ) || ( docker create --name docker-data wangcong/docker-data )

## delete $BASE_NAME container
#( docker ps -a |grep '$BASE_NAME' >/dev/null ) && ( docker rm $BASE_NAME )
#( docker ps -a |grep '$BASE_NAME' >/dev/null ) && ( docker start $(docker ps -a |grep '$BASE_NAME' |awk '{print $1}') )
( docker ps -a |grep '$BASE_NAME' >/dev/null ) && ( docker start '$BASE_NAME' )

## start $BASE_NAME container
docker run --name=$BASE_NAME -d \
	-e MYSQL_LOGIN="test" \
	-e MYSQL_PASSWORD="test" \
	--volumes-from docker-data \
	-p 80:80 \
	-p 443:443 \
	-p 3306:3306 \
	-p 122:22 \
	-v "$DIR"/../etc/nginx/nginx.conf:/etc/nginx/nginx.conf \
	-v "$DIR"/../etc/nginx/hosts/:/etc/nginx/hosts/ \
	-v "$DIR"/../etc/php-fpm.conf:/etc/php-fpm.conf \
	-v "$DIR"/../etc/php-fpm.d/:/etc/php-fpm.d/ \
	-v "$DIR"/../etc/php.ini:/etc/php.ini \
	-v "$DIR"/../etc/my.cnf:/etc/my.cnf \
	-v "$DIR"/../etc/postfix/main.cf:/etc/postfix/main.cf \
	-v "$DIR"/../www:/home/dev/www \
	-v "$DIR"/../logs:/home/dev/logs \
	-v "$DIR"/../.ssh:/home/dev/.ssh \
        $IMAGE_ID

#docker run registry.aliyuncs.com/wangcong/centos6base
