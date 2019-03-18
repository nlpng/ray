# The examples Docker image adds dependencies needed to run the examples
ARG cuda_version=9.0
ARG cudnn_version=7
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel

ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:${LD_LIBRARY_PATH}

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    cmake \
    locales\
    python3 \
    python3-dev \
    python3-pip \
    python3-wheel \
    && apt-get install -y --no-install-recommends \
    python3-pil \
    libjpeg8-dev \
    zlib1g-dev \
    liblapack-dev \
    git \
    wget \
    curl \
    make \
    build-essential \
    libssl-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip \
    && pip install -U setuptools wheel \
    && pip install -U ray \
    && pip install --no-cache-dir psutil setproctitle \
    && pip install tensorflow-gpu==1.10.0 \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*.deb \
        /var/cache/apt/archives/partial/*.deb \
        /var/cache/apt/*.bin \
    && find /usr/lib/python3 -name __pycache__ | xargs rm -rf \
    && rm -rf /root/.[acpw]*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD . /py_ws
WORKDIR /py_ws

ENV PYTHONPATH /py_ws