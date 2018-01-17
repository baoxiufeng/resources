#!/bin/sh
#author:baoxiufeng
#---unused

CLUSTER_NAME="MY-ELK"

s=1; e=3
case $# in
   1)
      CLUSTER_NAME=$1
   ;;
   2)
      s=$1;e=$2
      if [ $1 -gt $2 ]; then
         s=$2;e=$1
      fi
   ;;
   3)
      CLUSTER_NAME=$1         
      s=$2;e=$3               
      if [ $s -gt $e ]; then  
         s=$3;e=$2            
      fi                      
   ;;
esac

NODES_INDEX=""
for i in `seq $s $e`
do
   if [ "$NODES_INDEX" = "" ]; then
      NODES_INDEX=$i
   else
      NODES_INDEX=$NODES_INDEX' '$i
   fi
done

NODES_PORTS=""
for i in $NODES_INDEX
do
  if [ "$NODES_PORTS" = "" ]; then
    NODES_PORTS=`expr 9300 + $i`
  else
    NODES_PORTS=$NODES_PORTS','`expr 9300 + $i`
  fi
done
echo "$CLUSTER_NAME cluster nodes addr: "$NODES_PORTS

for i in $NODES_INDEX
do
  export HTTP_PORT=`expr 9200 + $i`
  export TCP_PORT=`expr 9300 + $i`
  echo "To run docker: centos/elk_$TCP_PORT"
  docker run -d --privileged --name elk_$TCP_PORT --net=host centos/elk sh -c "su - elasticsearch -c 'startElk.sh $CLUSTER_NAME $HTTP_PORT $TCP_PORT $NODES_PORTS'"
done
