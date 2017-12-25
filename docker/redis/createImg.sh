#!/bin/sh

for port in 6379 6380 6381 6389 6390 6391
do
  echo "Start to create docker image for redis_$port"
  ln -sf dockerfiles/dockerfile_$port dockerfile
  docker build -t bxf/redis_$port .
done
