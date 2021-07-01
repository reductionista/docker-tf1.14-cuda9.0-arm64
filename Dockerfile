FROM arm64v8/ubuntu:18.04

#
# Setup environment
#
ENV DEBIAN_FRONTEND=noninteractive
ARG HDF5_DIR="/usr/lib/aarch64-linux-gnu/hdf5/serial/"
ARG MAKEFLAGS=-j6

RUN printenv

#
# Install prerequisite debian packages
#
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python-pip \
        python-dev \
        gfortran \
        build-essential \
        liblapack-dev \ 
        libblas-dev \
        libhdf5-serial-dev \
        hdf5-tools \
        libhdf5-dev \
        zlib1g-dev \
        zip \
        libjpeg8-dev \
        pkg-config \
        wget \
        gnupg2 \
        sudo \
 && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd ngd -m --password '' -G sudo -s /bin/bash

#
# Install CUDA 9.0 packages
#
COPY --chown=ngd:ngd ./packages /home/ngd/cuda-l4t
USER ngd
WORKDIR /home/ngd/cuda-l4t
RUN sh ./cuda-l4t.sh cuda-repo-l4t-9-0-local_9.0.252-1_arm64.deb 9.0 9-0
RUN sudo dpkg -i libcudnn7-dev_7.1.5.14-1+cuda9.0_arm64.deb \
                 libcudnn7_7.1.5.14-1+cuda9.0_arm64.deb \
                 libcudnn7-doc_7.1.5.14-1+cuda9.0_arm64.deb

# 
# Set CUDA environment
#
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"

#
# Install tensorflow prerequisite pip packages
#
RUN pip install pip -U && \
    pip install setuptools Cython wheel --no-python-version-warning && \
    pip install numpy --verbose --no-python-version-warning && \
    pip install h5py==2.10.0 --verbose --no-python-version-warning && \
    pip install future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 \
                keras_applications==1.0.8 gast==0.2.2 futures protobuf \
                pybind11 --verbose --no-python-version-warning

#
# Install tensorFlow package
#
ARG TENSORFLOW_URL=https://developer.download.nvidia.com/compute/redist/jp/v33/tensorflow-gpu/tensorflow_gpu-1.14.0+nv19.9-cp27-cp27mu-linux_aarch64.whl
ARG TENSORFLOW_WHL=tensorflow_gpu-1.14.0+nv19.9-cp27-cp27mu-linux_aarch64.whl

RUN wget --quiet --show-progress --progress=bar:force:noscroll --no-check-certificate ${TENSORFLOW_URL} -O ${TENSORFLOW_WHL} && \
    pip install --user ${TENSORFLOW_WHL} --verbose --no-python-version-warning

# Copy some basic tests into container
COPY ./test /home/ngd/
