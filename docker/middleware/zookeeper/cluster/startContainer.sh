#!/bin/bash

container_id=$(docker ps |grep zookeeper-cluster | awk '{print $1}')
if [ ${container_id} ]; then
   echo "stop the zookeeper cluster docker container ": $(docker rm -f ${container_id})
fi

NAME=zookeeper-cluster
SPS=1
EPS=3

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

docker run -d --net=host --name $NAME -e SPS=$SPS -e EPS=$EPS bxf/zookeeper-cluster
container_id=$(docker ps |grep zookeeper-cluster | awk '{print $1}')
echo "start zookeeper cluster docker container: " ${container_id}
docker logs -f ${container_id}
