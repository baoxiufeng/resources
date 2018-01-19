#!/bin/bash

container_ids=$(docker ps -qa)
if [ ${container_ids} ]; then
   docker rm -f ${container_ids}
fi
