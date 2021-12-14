# Dockerfile combined from:
# https://github.com/openai/gym/blob/master/py.Dockerfile
# https://github.com/DLR-RM/stable-baselines3/blob/master/Dockerfile
# 
# 

LABEL maintainer="https://github.com/hu-po"

ARG PARENT_IMAGE
FROM $PARENT_IMAGE
ARG PYTORCH_DEPS=cpuonly
ARG PYTHON_VERSION=3.7

EXPOSE 8888

RUN apt-get update && apt-get install -y --no-install-recommends \
    # Stable Baselines 
    build-essential \
    cmake \
    git \
    curl \
    ca-certificates \
    libjpeg-dev \
    libpng-dev \
    libglib2.0-0 && \
    # OpenAI Gym
    unzip \
    patchelf \
    ffmpeg \
    swig \
    # Jupyter
    tzdata \
    vim-tiny
RUN rm -rf /var/lib/apt/lists/*

ENV CODE_DIR /root/code

# Install Anaconda and dependencies
RUN curl -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include && \
     /opt/conda/bin/conda install -y pytorch $PYTORCH_DEPS -c pytorch && \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH

# Copy setup file only to install dependencies
COPY ./setup.py ${CODE_DIR}/stable-baselines3/setup.py
COPY ./stable_baselines3/version.txt ${CODE_DIR}/stable-baselines3/stable_baselines3/version.txt

RUN pip install -r requirements.txt && \
    rm -rf $HOME/.cache/pip

# RUN \
#     cd ${CODE_DIR}/stable-baselines3 3&& \
#     pip install -e .[extra,tests,docs] && \
#     # Use headless version for docker
#     pip uninstall -y opencv-python && \
#     pip install opencv-python-headless && \
#     rm -rf $HOME/.cache/pip

# # TODO: Install DynamixelSDK for servos
# RUN \
# $ git clone https://github.com/ROBOTIS-GIT/DynamixelSDK.git .
# $ cd DynamixelSDK/python/
# $ pip install -e .
# pip install dxl_py

COPY . /usr/local/gym/
WORKDIR /usr/local/gym/

RUN pip install -r requirements.txt

CMD jupyter notebook