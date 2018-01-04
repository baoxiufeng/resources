#!/bin/sh
#author:baoxiufeng

for i in 1 2 3
do
  export HTTP_PORT=`expr 9200 + $i`
  export TCP_PORT=`expr 9300 + $i`
  echo "To run docker: centos/elk_$TCP_PORT"
  docker run -d --privileged --name elk_$TCP_PORT --net=host centos/elk sh -c "su - elasticsearch -c 'startElk.sh MY-ELK $HTTP_PORT $TCP_PORT'"
done
