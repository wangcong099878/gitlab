#!/bin/sh

BASE_NAME="centos6base"
TAG_NAME=$1
if [ -z "$TAG_NAME" ]
then
        IMAGE_NAME=$BASE_NAME
        IMAGE_ID=$(docker images | grep $BASE_NAME | grep master | awk 'NR<2{print $3}')
else
        IMAGE_NAME=$BASE_NAME:$TAG_NAME
        IMAGE_ID=$(docker images | grep $BASE_NAME | grep $TAG_NAME | awk 'NR<2{print $3}')
fi


if [ ! -n "$IMAGE_ID" ]; then
    IMAGE_ID=$(docker images | grep $BASE_NAME | awk 'NR<2{print $3}')
    if [ ! -n "$IMAGE_ID" ]; then
        echo "IS NULL not image id"
        exit 0
    fi
fi
