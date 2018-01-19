#!/bin/bash

container_id=$(docker ps |grep redis-cluster-util | awk '{print $1}')
if [ ${container_id} ]; then
   echo "stop the redis cluster util docker container ": $(docker rm -f ${container_id})
fi

docker run -d --net=host --name redis-cluster-util -e SPS=$1 -e EPS=$2 bxf/redis-cluster-util
container_id=$(docker ps |grep redis-cluster-util | awk '{print $1}')
echo "start redis cluster util docker container: " ${container_id}
docker logs -f ${container_id}
