#! /bin/bash

cd /home/dockeruser/cuda_compute/

CONTAINER_ID=$(cat $(pwd)/container_id)

NUM_PYTHON_PROCESSES=$(docker top $CONTAINER_ID | grep -v -e 'supervisord' | grep -v -e 'jupyterhub ' | grep -ic -E "python|rsession")

if [ $NUM_PYTHON_PROCESSES -gt 0 ]; then
  echo 'python or rsession is running'
else
  $(pwd)/stop_container.sh
  $(pwd)/build_container.sh
  $(pwd)/create_container.sh
  $(pwd)/start_container.sh
fi
