#!/bin/sh

DIR=$(cd "$(dirname "$0")"; pwd) 
source $DIR/config.sh

## create docker-data container if does not exist
( docker ps -a |grep 'docker-data' >/dev/null ) || ( docker run --name docker-data -i -t wangcong/docker-data )

## delete $IMAGE_NAME container
( docker ps -a |grep '$BASE_NAME' >/dev/null ) && ( docker stop $BASE_NAME && docker rm $BASE_NAME)

## start $IMAGE_NAME container
docker run --name=$BASE_NAME -t -i --rm=true \
	-p 80:80 \
	-p 443:443 \
	-p 3306:3306 \
	-e MYSQL_LOGIN="test" \
	-e MYSQL_PASSWORD="test" \
	--volumes-from docker-data \
	-v "$DIR"/../etc/nginx/nginx.conf:/etc/nginx/nginx.conf \
	-v "$DIR"/../etc/nginx/hosts/:/etc/nginx/hosts/ \
	-v "$DIR"/../etc/php-fpm.conf:/etc/php-fpm.conf \
	-v "$DIR"/../etc/php-fpm.d/:/etc/php-fpm.d/ \
	-v "$DIR"/../etc/php.ini:/etc/php.ini \
	-v "$DIR"/../etc/my.cnf:/etc/my.cnf \
	-v "$DIR"/../www:/home/dev/www \
	-v "$DIR"/../etc/postfix/main.cf:/etc/postfix/main.cf \
	-v "$DIR"/../logs:/home/dev/logs \
	-v "$DIR"/../.ssh:/home/dev/.ssh \
	$IMAGE_ID /bin/bash


#docker run --name=centos6 -t -i --rm=true -p 10022:22 registry.aliyuncs.com/wangcong/centos6base /bin/bash
