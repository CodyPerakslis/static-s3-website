#!/bin/bash

if [[ "$1" == "-s" ]]; then
  if [ ! -z "$2" ]; then
    docker run \
      --name nginx-$2 \
      -v `pwd`/local/conf.d/:/etc/nginx/conf.d/ \
      -v `pwd`/$2/:/usr/share/html/ \
      -d -p 80:80 nginx
    echo "Running on localhost:80"
  fi
else
  if [ ! -z "$2" ]; then
    docker rm -f nginx-$2
  fi
fi
