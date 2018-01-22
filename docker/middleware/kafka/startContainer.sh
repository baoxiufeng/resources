#!/bin/bash

container_id=$(docker ps |grep kafka-cluster | awk '{print $1}')
if [ ${container_id} ]; then
   echo "stop the kafka cluster docker container ": $(docker rm -f ${container_id})
fi

NAME=kafka-cluster
SPS=1
EPS=3
ZKSPS=1
ZKEPS=3

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
   4)
      SPS=$1
      EPS=$2
      ZKSPS=$3
      ZKEPS=$4
   ;;
   5)
      NAME=$1
      SPS=$2
      EPS=$3
      ZKSPS=$4
      ZKEPS=$5
   ;;
esac

HOST_IP=`ifconfig eth0 |grep "inet addr"|awk -F' ' '{print $2}'|awk -F ':' '{print $2}'`

docker run -d --net=host --name $NAME -e HOST_IP=$HOST_IP -e SPS=$SPS -e EPS=$EPS -e ZKSPS=$ZKSPS -e ZKEPS=$ZKEPS bxf/kafka-cluster
container_id=$(docker ps |grep kafka-cluster | awk '{print $1}')
echo "start kafka cluster docker container: " ${container_id}
docker logs -f ${container_id}
