#!/bin/sh
#author:baoxiufeng

echo "Start to create redis cluster tool docker image..."
cd ruby
docker build -t bxf/ruby_redis .
