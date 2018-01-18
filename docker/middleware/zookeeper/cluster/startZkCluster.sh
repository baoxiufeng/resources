#!/bin/bash

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
   echo "server.$i=127.0.0.1:`expr 2888 + $i`:`expr 3888 + $i`" >> ${ZK_HOME}/conf/zoo.cfg
   mkdir ${ZK_HOME}/data/`expr 2181 + $i`
   mkdir ${ZK_HOME}/datalogs/`expr 2181 + $i`
   echo "$i" >> ${ZK_HOME}/data/`expr 2181 + $i`/myid
done

endPortSeq=`expr $endPortSeq - 1`
for i in `seq $startPortSeq $endPortSeq`
do
   CLIENT_PORT=`expr 2181 + $i`
   cp ${ZK_HOME}/conf/zoo.cfg ${ZK_HOME}/conf/zoo_${CLIENT_PORT}.cfg
   echo "dataDir=${ZK_HOME}/data/${CLIENT_PORT}" >> ${ZK_HOME}/conf/zoo_${CLIENT_PORT}.cfg
   echo "dataLogDir=${ZK_HOME}/datalogs/${CLIENT_PORT}" >> ${ZK_HOME}/conf/zoo_${CLIENT_PORT}.cfg
   echo "clientPort=${CLIENT_PORT}" >> ${ZK_HOME}/conf/zoo_${CLIENT_PORT}.cfg
   ${ZK_HOME}/bin/zkServer.sh start zoo_${CLIENT_PORT}.cfg
done

CLIENT_PORT=`expr 2181 + $endPortSeq + 1`
cp ${ZK_HOME}/conf/zoo.cfg ${ZK_HOME}/conf/zoo_${CLIENT_PORT}.cfg
echo "dataDir=${ZK_HOME}/data/${CLIENT_PORT}" >> ${ZK_HOME}/conf/zoo_${CLIENT_PORT}.cfg
echo "dataLogDir=${ZK_HOME}/datalogs/${CLIENT_PORT}" >> ${ZK_HOME}/conf/zoo_${CLIENT_PORT}.cfg
echo "clientPort=${CLIENT_PORT}" >> ${ZK_HOME}/conf/zoo_${CLIENT_PORT}.cfg
${ZK_HOME}/bin/zkServer.sh start-foreground zoo_${CLIENT_PORT}.cfg
