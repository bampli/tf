ARG BASEIMAGE=arm32v7/debian:stretch-slim
FROM ${BASEIMAGE}

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG TFVERSION
LABEL mantainer="Jose Motta <josemotta@bampli.com>" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="tf" \
    org.label-schema.description="OpenCV-Tensorflow-Python3.7:arm32v7" \
    org.label-schema.url="https://bampli.com" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/bampli/tf" \
    org.label-schema.vendor="bAmpli" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="0.1"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libatlas-base-dev \
      python3-dev python3-pip python3-h5py \
      build-essential cmake git wget unzip yasm pkg-config \
      libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev \
      libavformat-dev libpq-dev \
      libssl-dev openssl libffi-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /
RUN wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz && \
    tar xf Python-3.7.3.tar.xz && \
    cd Python-3.7.3 && \
    ./configure && \
    make && \
    make altinstall && \
    cd .. && \
    rm -r Python-3.7.3 && \
    rm Python-3.7.3.tar.xz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN mkdir -p $HOME/.config/pip && \
    touch $HOME/.config/pip/pip.conf && \
    echo "[global]" >> $HOME/.config/pip/pip.conf && \
    echo "extra-index-url=https://www.piwheels.org/simple" >> $HOME/.config/pip/pip.conf

ARG WHL_FILE=tensorflow==$TFVERSION
RUN python3.7 -m pip install --upgrade pip setuptools && \
    pip --no-cache-dir install --target=/usr/local/bin --upgrade $WHL_FILE
# RUN pip3 install keras
# RUN pip3 install pillow
# RUN pip3 install numpy

# WORKDIR /
# ENV OPENCV_VERSION="3.4.3"
# RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
# && unzip ${OPENCV_VERSION}.zip \
# && mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
# && cd /opencv-${OPENCV_VERSION}/cmake_binary \
# && cmake -DBUILD_TIFF=ON \
#   -DBUILD_opencv_java=OFF \
#   -DWITH_CUDA=OFF \
#   -DWITH_OPENGL=ON \
#   -DWITH_OPENCL=ON \
#   -DWITH_IPP=ON \
#   -DWITH_TBB=ON \
#   -DWITH_EIGEN=ON \
#   -DWITH_V4L=ON \
#   -DBUILD_TESTS=OFF \
#   -DBUILD_PERF_TESTS=OFF \
#   -DCMAKE_BUILD_TYPE=RELEASE \
#   -DCMAKE_INSTALL_PREFIX=$(python3.7 -c "import sys; print(sys.prefix)") \
#   -DPYTHON_EXECUTABLE=$(which python3.7) \
#   -DPYTHON_INCLUDE_DIR=$(python3.7 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
#   -DPYTHON_PACKAGES_PATH=$(python3.7 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
#   .. \
# && make install \
# && rm /${OPENCV_VERSION}.zip \
# && rm -r /opencv-${OPENCV_VERSION}
