#!/bin/sh

for id in $(docker ps -q)
do
  echo "Ready to stop docker container:$id"
  echo "The container $(docker stop $id) is stoped."
done

echo "To remove all stoped docker container:"
docker rm $(docker ps -aq)
