#!/bin/sh

for port in 6379 6380 6381 6389 6390 6391
do
  echo "To run docker: bxf/redis_$port"
  docker run -d --name redis_$port --net=host bxf/redis_$port
done
