# ------ OpenAI Gym: https://github.com/openai/gym/blob/master/py.Dockerfile

# A Dockerfile that sets up a full Gym install with test dependencies
ARG PYTHON_VERSION
FROM python:$PYTHON_VERSION
RUN apt-get -y update && apt-get install -y unzip libglu1-mesa-dev libgl1-mesa-dev libosmesa6-dev xvfb patchelf ffmpeg cmake swig

# Download mujoco
RUN mkdir /root/.mujoco && \
    cd /root/.mujoco  && \
    curl -O https://www.roboti.us/download/mjpro150_linux.zip && \
    unzip mjpro150_linux.zip && \
    echo DUMMY_KEY > /root/.mujoco/mjkey.txt

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/root/.mujoco/mjpro150/bin

COPY . /usr/local/gym/
WORKDIR /usr/local/gym/

RUN pip install .[nomujoco] && pip install -r test_requirements.txt

ENTRYPOINT ["/usr/local/gym/bin/docker_entrypoint"]

# ------ Stable Baselines: https://github.com/DLR-RM/stable-baselines3/blob/master/Dockerfile

ARG PARENT_IMAGE
FROM $PARENT_IMAGE
ARG PYTORCH_DEPS=cpuonly
ARG PYTHON_VERSION=3.7

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         ca-certificates \
         libjpeg-dev \
         libpng-dev \
         libglib2.0-0 && \
     rm -rf /var/lib/apt/lists/*

# Install Anaconda and dependencies
RUN curl -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include && \
     /opt/conda/bin/conda install -y pytorch $PYTORCH_DEPS -c pytorch && \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH

ENV CODE_DIR /root/code

# Copy setup file only to install dependencies
COPY ./setup.py ${CODE_DIR}/stable-baselines3/setup.py
COPY ./stable_baselines3/version.txt ${CODE_DIR}/stable-baselines3/stable_baselines3/version.txt

RUN \
    cd ${CODE_DIR}/stable-baselines3 3&& \
    pip install -e .[extra,tests,docs] && \
    # Use headless version for docker
    pip uninstall -y opencv-python && \
    pip install opencv-python-headless && \
    rm -rf $HOME/.cache/pip

CMD /bin/bash
