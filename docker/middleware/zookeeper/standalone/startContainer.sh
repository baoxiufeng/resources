#!/bin/bash

container_id=$(docker ps |grep zookeeper-standalone | awk '{print $1}')
if [ ${container_id} ]; then
   echo "stop the zookeeper docker container ": $(docker rm -f ${container_id})
fi

SPS=1
EPS=3

case $# in
   1)
      SPS=$1
      EPS=`expr $1 + $EPS`
   ;;
   2)
      SPS=$1
      EPS=$2
   ;;
esac

docker run -d --net=host --name zookeeper-standalone bxf/zookeeper
container_id=$(docker ps |grep zookeeper-standalone | awk '{print $1}')
echo "start zookeeper docker container: " ${container_id}
docker logs -f ${container_id}
