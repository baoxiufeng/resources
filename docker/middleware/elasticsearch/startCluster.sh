#!/bin/sh

#docker run -d --privileged --name $2 --net=host bxf/elasticsearch$1 sh -c "su - elasticsearch -c 'startCluster.sh $2 $3 $4'"
docker run -d --privileged --name $1 --net=host bxf/elasticsearch sh -c "su - elasticsearch -c 'sh /opt/es/startEs.sh $1 $2 $3'"
docker ps -a
