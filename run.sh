#!/bin/bash

docker run \
  -p 8888:8888 \
  -e JUPYTER_ENABLE_LAB=yes \
  -v /tmp/data:/tmp/data

