BASE_IMAGE=arm64v8/ubuntu:18.04
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

#
# setup environment
#
ENV DEBIAN_FRONTEND=noninteractive
ARG HDF5_DIR="/usr/lib/aarch64-linux-gnu/hdf5/serial/"
ARG MAKEFLAGS=-j6

RUN printenv

#
# install prerequisites - https://docs.nvidia.com/deeplearning/frameworks/install-tf-jetson-platform/index.html#prereqs
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
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U pip
RUN pip install setuptools Cython wheel
RUN pip install numpy --verbose
RUN pip install h5py==2.10.0 --verbose
RUN pip install future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11 --verbose

#
# TensorFlow 
#
ARG TENSORFLOW_URL=https://developer.download.nvidia.com/compute/redist/jp/v33/tensorflow-gpu/tensorflow_gpu-1.14.0+nv19.9-cp27-cp27mu-linux_aarch64.whl
ARG TENSORFLOW_WHL=tensorflow_gpu-1.14.0+nv19.9-cp27-cp27mu-linux_aarch64.whl

RUN wget --quiet --show-progress --progress=bar:force:noscroll --no-check-certificate ${TENSORFLOW_URL} -O ${TENSORFLOW_WHL} && \
    pip install ${TENSORFLOW_WHL} --verbose && \
    rm ${TENSORFLOW_WHL}

#
# Install CUDA 9.0
#
COPY ./packages/*.deb /
COPY ./scripts/cuda-l4t.sh /

# 
# PyCUDA
#
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"
RUN echo "$PATH" && echo "$LD_LIBRARY_PATH"

RUN pip install pycuda six --verbose

