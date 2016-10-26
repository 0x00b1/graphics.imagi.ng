#! /bin/bash

cd /home/dockeruser/cuda_compute/

CONTAINER_ID=$(cat /home/dockeruser/cuda_compute/container_id)

NUM_PYTHON_PROCESSES=$(docker top $CONTAINER_ID | grep -v -e 'supervisord' | grep -v -e 'jupyterhub ' | grep -ic -E "python|rsession")

if [ $NUM_PYTHON_PROCESSES -gt 0 ]; then
  echo 'python or rsession is running'
else
  ./stop_container.sh
  ./build_container.sh
  ./create_container.sh
  ./start_container.sh
fi
