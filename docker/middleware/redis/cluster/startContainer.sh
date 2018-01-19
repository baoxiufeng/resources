#!/bin/bash

container_id=$(docker ps |grep redis-cluster | awk '{print $1}')
if [ ${container_id} ]; then
   echo "stop the redis cluster docker container ": $(docker rm -f ${container_id})
fi

NAME=redis-cluster
SPS=1
EPS=6

case $# in
   1)
      NAME=$1
   ;;
   2)
      SPS=$1
      EPS=$2
   ;;
   3)
      NAME=$1
      SPS=$2
      EPS=$3
   ;;
esac

docker run -d --privileged --net=host --name $NAME -e SPS=$SPS -e EPS=$EPS bxf/redis-cluster
container_id=$(docker ps |grep redis-cluster | awk '{print $1}')
echo "start redis cluster docker container: " ${container_id}
docker logs -f ${container_id}
