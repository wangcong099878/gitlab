#!/bin/sh

## check running container
id=`docker ps -q`
if [ "$id" = "" ]; then
  echo "Not found running container!"
  exit 1
fi

DIR=$(cd "$(dirname "$0")"; pwd) 
source $DIR/config.sh
SSH_KEY="$DIR/../.ssh/id_rsa"
#IP_ADDRESS=`docker ps -q | head -n1 | xargs docker inspect |grep 'IPAddress' | cut -d '"' -f 4`
IP_ADDRESS=`docker ps | grep $BASE_NAME | awk '{print $1}' | xargs  docker inspect --format='{{.NetworkSettings.IPAddress}}'`

## set right perms
chmod 700 "$DIR/../.ssh"
chmod 400 $SSH_KEY

echo "$DIR/../.ssh"
## connect
ssh -i "$SSH_KEY" -l dev -q "$IP_ADDRESS"
#ssh "dev@$IP_ADDRESS"

exit 0

