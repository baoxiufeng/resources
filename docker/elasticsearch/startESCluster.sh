#!/bin/sh

docker run -d --privileged --name $2 --net=host bxf/elasticsearch$1 sh -c "su - elasticsearch -c 'startCluster.sh $2 $3 $4'"
docker ps -a
