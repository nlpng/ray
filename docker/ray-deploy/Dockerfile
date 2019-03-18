# The examples Docker image adds dependencies needed to run the examples

FROM registry.leapmind.xyz/huang/ray-base

ENV BUILD_PACKAGES="\
        linux-headers-4.9 \
        cmake \
        tcl-dev \
        xz-utils \
        zlib1g-dev" \
    APT_PACKAGES="\
        ca-certificates \
        openssl \
        libpng16-16 \
        libfreetype6 \
        libjpeg62-turbo \
        libgomp1" \
    PIP_PACKAGES="\
        pyyaml \
        mkl \
        cffi \
        h5py \
        requests \
        pillow \
        graphviz \
        numpy \
        pandas \
        scipy \
        scikit-learn \
        seaborn \
        xgboost \
        hyperopt \
        tensorflow-gpu"

RUN set -ex \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ${APT_PACKAGES} \
    && apt-get install -y --no-install-recommends ${BUILD_PACKAGES} \
    && pip install -U -v setuptools wheel \
    && pip install -U -v ${PIP_PACKAGES} \
    && apt-get remove --purge --auto-remove -y ${BUILD_PACKAGES} \
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

# This updates numpy to 1.14 and mutes errors from other libraries
RUN pip install -y numpy opencv-python-headless lz4 pytest-timeout smart_open\
    && pip install --upgrade h5py bayesian-optimization hyperopt sigopt
