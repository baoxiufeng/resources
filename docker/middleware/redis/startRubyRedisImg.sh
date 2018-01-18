#!/bin/sh
#author:baoxiufeng

echo "To run redis cluster tool docker image: bxf/ruby_redis"
export CLUSTER_NODES="127.0.0.1:6379 127.0.0.1:6380 127.0.0.1:6381 127.0.0.1:6389 127.0.0.1:6390 127.0.0.1:6391"
echo $CLUSTER_NODES
docker run -it -e CLUSTER_NODES="$CLUSTER_NODES" --net=host bxf/ruby_redis /bin/bash
