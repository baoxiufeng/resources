#!/bin/bash

startPortSeq=${SPS}
endPortSeq=${EPS}
if [ ! ${SPS} ]; then
   startPortSeq=1
fi
if [ ! ${EPS} ]; then
   endPortSeq=3
fi
zkStartPortSeq=${ZKSPS}
zkEndPortSeq=${ZKEPS}
if [ ! ${ZKSPS} ]; then
   zkStartPortSeq=1
fi
if [ ! ${ZKEPS} ]; then
   zkEndPortSeq=3
fi

for i in `seq $zkStartPortSeq $zkEndPortSeq`
do
   if [ $zkStartPortSeq == $i ]; then
      ZK_ADDRS='127.0.0.1:'`expr 2181 + $i`
   else
      ZK_ADDRS=${ZK_ADDRS}',127.0.0.1:'`expr 2181 + $i`
   fi
done
echo "" >> ${KAFKA_HOME}/config/server.properties
echo "zookeeper.connect=${ZK_ADDRS}" >> ${KAFKA_HOME}/config/server.properties

cd ${KAFKA_HOME}

endPortSeq=`expr $endPortSeq - 1`
for i in `seq $startPortSeq $endPortSeq`
do
   PORT=`expr 9092 + $i`
   cp config/server.properties conf/server_${PORT}.properties
   echo "broker.id=$i" >> conf/server_${PORT}.properties
   echo "port=${PORT}" >> conf/server_${PORT}.properties
   echo "advertised.listeners=PLAINTEXT://${HOST_IP}:${PORT}" >> conf/server_${PORT}.properties
   echo "log.dirs=${KAFKA_HOME}/data/${PORT}" >> conf/server_${PORT}.properties
   mkdir -p data/${PORT}
   bin/kafka-server-start.sh -daemon conf/server_${PORT}.properties   
done

endPortSeq=`expr $endPortSeq + 1`
PORT=`expr 9092 + $endPortSeq`
cp config/server.properties conf/server_${PORT}.properties
echo "broker.id=$endPortSeq" >> conf/server_${PORT}.properties                   
echo "advertised.listeners=PLAINTEXT://${HOST_IP}:${PORT}" >> conf/server_${PORT}.properties
echo "port=${PORT}" >> conf/server_${PORT}.properties                      
echo "log.dirs=${KAFKA_HOME}/data/${PORT}" >> conf/server_${PORT}.properties
mkdir -p data/${PORT}                                                      
bin/kafka-server-start.sh conf/server_${PORT}.properties
