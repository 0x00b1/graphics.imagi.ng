#! /bin/bash

nvidia-docker create                                   \
  --env-file=env                                       \
  --name cuda_compute                                  \
  -p 9100:8000                                         \
  -p 9122:22                                           \
  -p 9187:8787                                         \
  -v /data:/data                                       \
  -v /mnt/data1:/data1                                 \
  -v /mnt/data2:/data2                                 \
  -v home:/home                                        \
  -v ssl_secrets:/etc/letsencrypt                      \
  cuda_compute
