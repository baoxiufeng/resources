#!/bin/sh
#author:baoxiufeng

for i in `seq $SPS $EPS`
do
  if [ $SPS == $i ]; then
     CLUSTER_NODES="127.0.0.1:`expr 6379 + $i`"
  else
     CLUSTER_NODES=${CLUSTER_NODES}" 127.0.0.1:`expr 6379 + $i`"
  fi
done

echo "yes" | /usr/local/redis/src/redis-trib.rb create --replicas 1 ${CLUSTER_NODES}
