#!/bin/sh

echo "Start to create docker image for redis:$1"

ln -sf dockerfiles/dockerfile_$1 dockerfile
docker build -t bxf/redis_$1 .
