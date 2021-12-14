# ------ OpenAI Gym: https://github.com/openai/gym/blob/42a4a09f5b5a0eaa8c1ac485e6f7e49e5fc56971/.github/workflows/build.yml

name: build
on: [pull_request, push]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ['3.7', '3.8', '3.9', '3.10']
    steps:
      - uses: actions/checkout@v2
      - run: |
           docker build -f py.Dockerfile \
             --build-arg MUJOCO_KEY=$MUJOCO_KEY \
             --build-arg PYTHON_VERSION=${{ matrix.python-version }} \
             --tag gym-docker .
      - name: Run tests
        run: docker run gym-docker pytest --forked --import-mode=append


# ------ Stable Baselines: https://github.com/DLR-RM/stable-baselines3/blob/ddbe0e93f9fe55152f2354afd058b28e6ccc3345/scripts/build_docker.sh

#!/bin/bash

CPU_PARENT=ubuntu:18.04
GPU_PARENT=nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04

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

echo "docker build --build-arg PARENT_IMAGE=${PARENT} --build-arg PYTORCH_DEPS=${PYTORCH_DEPS} -t ${TAG}:${VERSION} ."
docker build --build-arg PARENT_IMAGE=${PARENT} --build-arg PYTORCH_DEPS=${PYTORCH_DEPS} -t ${TAG}:${VERSION} .
docker tag ${TAG}:${VERSION} ${TAG}:latest

if [[ ${RELEASE} == "True" ]]; then
  docker push ${TAG}:${VERSION}
  docker push ${TAG}:latest
fi