#!/bin/bash
if [ -z "$1" ];
then
	echo "Usage: $0 CONTAINER"
	exit 1
fi

CONTAINER="$1"
docker cp -a ~/.bitfusion "$CONTAINER:/home/ngd/"
docker cp ~/.bitfusion/servers.conf "$CONTAINER:/home/ngd/.bitfusion/server.conf.orig"
sudo docker cp -a /etc/bitfusion "$CONTAINER:/etc/"
