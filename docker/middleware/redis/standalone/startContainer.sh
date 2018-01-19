#!/bin/bash

REDIS_PORT=6379
CLUSTER_MODE=0

case $# in
   1)
      REDIS_PORT=$1
   ;;
   2)
      REDIS_PORT=$1
      CLUSTER_MODE=$2
   ;;
esac

# stop redis docker container in running.
container_id=$(docker ps |grep redis-standalone-${REDIS_PORT} | awk '{print $1}')
if [ ${container_id} ]; then
   echo "stop the redis docker container ": $(docker rm -f ${container_id})
fi

# start redis dcoker container and print container start log.
docker run -d --net=host -e REDIS_PORT=${REDIS_PORT} -e CLUSTER_MODE=${CLUSTER_MODE} --name redis-standalone-${REDIS_PORT} bxf/redis
container_id=$(docker ps |grep redis-standalone-${REDIS_PORT} | awk '{print $1}')
echo "start redis docker container: " ${container_id}
docker logs -f ${container_id}

