#!/bin/sh
#author:baoxiufeng

echo "To entry one redis client of redis cluster: bxf/redis_$1"
container_id=$(docker ps |grep redis_$1 | awk -F ' '  'END {print $1}')
docker exec -it $container_id /bin/bash
