#!/bin/bash

cd ${KAFKA_HOME}

startPortSeq=${SPS}
endPortSeq=${EPS}
if [ ! ${SPS} ]; then
   startPortSeq=1
fi
if [ ! ${EPS} ]; then
   endPortSeq=3
fi

for i in `seq $startPortSeq $endPortSeq`
do
   if [ $startPortSeq == $i ]; then
      BROKER_LIST='127.0.0.1:'`expr 9092 + $i`
   else
      BROKER_LIST=${BROKER_LIST}',127.0.0.1:'`expr 9092 + $i`
   fi
done

bin/kafka-console-consumer.sh --bootstrap-server ${BROKER_LIST} --topic $1 --from-beginning 
