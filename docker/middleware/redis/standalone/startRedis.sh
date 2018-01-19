#!/bin/bash

# init sysctl config
sysctl vm.overcommit_memory=1
sysctl net.core.somaxconn=1024
echo never > /sys/kernel/mm/transparent_hugepage/enabled

if [ ! ${REDIS_PORT} ]; then
   REDIS_PORT=6379
fi

if [ ! ${CLUSTER_MODE} ]; then
   CLUSTER_MODE=0
fi

cd ${REDIS_HOME}/conf
echo "port ${REDIS_PORT}" > redis.conf
echo "dir /var/redis/data" >> redis.conf

if [ $CLUSTER_MODE == 1 ]; then
   echo "cluster-enabled yes" >> redis.conf
   echo "cluster-config-file nodes.conf" >> redis.conf
fi

# start redis server 
redis-server /usr/local/conf/redis.conf
