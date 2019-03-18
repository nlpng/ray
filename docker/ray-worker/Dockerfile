# The examples Docker image adds dependencies needed to run the examples

FROM registry.leapmind.xyz/huang/ray-head

# This updates numpy to 1.14 and mutes errors from other libraries
RUN conda install -y numpy
RUN pip install opencv-python-headless lz4 pytest-timeout smart_open
RUN pip install --upgrade h5py bayesian-optimization hyperopt sigopt