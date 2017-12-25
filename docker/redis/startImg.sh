#!/bin/sh

docker run -d --name redis_$1 --net=host bxf/redis_$1
