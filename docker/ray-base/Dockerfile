# The base-deps Docker image installs to run Ray

FROM ubuntu:xenial
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        wget \
        curl \
        build-essential \
        autoconf \
        python3-pip \
        python3-dev \
        locales \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip \
    && pip install -U setuptools wheel \
    && pip install -U ray \
    && pip install psutil \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /ray-head
