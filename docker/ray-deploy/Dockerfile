# The examples Docker image adds dependencies needed to run the examples

FROM registry.leapmind.xyz/huang/ray-base

# This updates numpy to 1.14 and mutes errors from other libraries
RUN pip install -y numpy opencv-python-headless lz4 pytest-timeout smart_open\
    && pip install --upgrade h5py bayesian-optimization hyperopt sigopt
