#!bin/sh

for i in 1
do
   HTTP_PORT=`expr 9200 + $i`
   TCP_PORT=`expr 9300 + $i`
   export HTTP_PORT TCP_PORT
   echo $HTTP_PORT && echo $TCP_PORT
   docker build -t bxf/elasticsearch_$TCP_PORT .
done
