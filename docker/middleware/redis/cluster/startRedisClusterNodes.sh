#!/bin/bash

# init sysctl config
sysctl vm.overcommit_memory=1
sysctl net.core.somaxconn=1024
echo never > /sys/kernel/mm/transparent_hugepage/enabled

startPortSeq=${SPS}
endPortSeq=${EPS}
if [ ! ${SPS} ]; then
   startPortSeq=1
fi
if [ ! ${EPS} ]; then
   endPortSeq=6
fi

endPortSeq=`expr $endPortSeq - 1`

cd ${REDIS_HOME}/conf

for i in `seq $startPortSeq $endPortSeq`
do
   REDIS_PORT=`expr 6379 + $i`
   echo "port ${REDIS_PORT}" > redis_${REDIS_PORT}.conf
   echo "dir /var/redis/data" >> redis_${REDIS_PORT}.conf
   echo "dbfilename dump_${REDIS_PORT}.db" >> redis_${REDIS_PORT}.conf
   echo "cluster-enabled yes" >> redis_${REDIS_PORT}.conf
   echo "cluster-config-file nodes_${REDIS_PORT}.conf" >> redis_${REDIS_PORT}.conf
   # start redis server 
   redis-server /usr/local/conf/redis_${REDIS_PORT}.conf &
done

REDIS_PORT=`expr 6379 + $endPortSeq + 1`
echo "port ${REDIS_PORT}" > redis_${REDIS_PORT}.conf                                   
echo "dir /var/redis/data" >> redis_${REDIS_PORT}.conf
echo "dbfilename dump_${REDIS_PORT}.db" >> redis_${REDIS_PORT}.conf
echo "cluster-enabled yes" >> redis_${REDIS_PORT}.conf           
echo "cluster-config-file nodes_${REDIS_PORT}.conf" >> redis_${REDIS_PORT}.conf
# start redis server                                             
redis-server /usr/local/conf/redis_${REDIS_PORT}.conf
