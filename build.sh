#!/bin/bash

# Builds the Dockerfile, inspired by:
# https://github.com/openai/gym/workflows/build.yml

CPU_PARENT=ubuntu:18.04
GPU_PARENT=nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04
PYTHON_VERSION=3.8

TAG=stablebaselines/stable-baselines3
VERSION=$(cat ./stable_baselines3/version.txt)

if [[ ${USE_GPU} == "True" ]]; then
  PARENT=${GPU_PARENT}
  PYTORCH_DEPS="cudatoolkit=10.1"
else
  PARENT=${CPU_PARENT}
  PYTORCH_DEPS="cpuonly"
  TAG="${TAG}-cpu"
fi

docker build \
  --build-arg PARENT_IMAGE=${PARENT}\
  --build-arg PYTORCH_DEPS=${PYTORCH_DEPS}\
  --build-arg PYTHON_VERSION=${PYTHON_VERSION}\
  -t ${TAG}:${VERSION} .
docker tag ${TAG}:${VERSION} ${TAG}:latest