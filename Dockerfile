ARG BASEIMAGE=schachr/raspbian-stretch:latest
FROM ${BASEIMAGE}

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG TFVERSION
LABEL mantainer="Jose Motta <josemotta@bampli.com>" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="tf" \
    org.label-schema.description="OpenCV-Tensorflow-Python3.7 for amd64 & arm32v7" \
    org.label-schema.url="https://bampli.com" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/bampli/tf" \
    org.label-schema.vendor="bAmpli" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

RUN apt-get purge python3.5-minimal python3-minimal

RUN apt-get update && apt-get install -y --no-install-recommends \
    libatlas-base-dev \
    python3-dev python3-pip python3-h5py \
    build-essential cmake git wget unzip yasm pkg-config \
    libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev \
    libavformat-dev libpq-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p $HOME/.config/pip && \
    touch $HOME/.config/pip/pip.conf && \
    echo "[global]" >> $HOME/.config/pip/pip.conf && \
    echo "extra-index-url=https://www.piwheels.org/simple" >> $HOME/.config/pip/pip.conf
 
RUN wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz && \
    tar xf Python-3.7.3.tar.xz && \
    cd Python-3.7.3 && \
    ./configure && \
    make && \
    sudo make altinstall

RUN sudo rm -r Python-3.7.3 && \
    rm Python-3.7.3.tar.xz && \
    sudo apt-get --purge remove build-essential tk-dev && \
    sudo apt-get --purge remove libncurses5-dev libncursesw5-dev libreadline6-dev && \
    sudo apt-get --purge remove libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev && \
    sudo apt-get --purge remove libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev && \
    sudo apt-get autoremove && \
    sudo apt-get clean

ARG WHL_FILE=tensorflow==$TFVERSION

RUN python3 -m pip install --upgrade pip setuptools && \
    pip3 --no-cache-dir install --user --upgrade $WHL_FILE && \
    pip3 install keras numpy pillow

ARG TF="https://storage.googleapis.com/tensorflow-nightly/tensorflow-1.10.0-cp34-none-linux_armv7l.whl"

WORKDIR /
ENV OPENCV_VERSION="3.4.3"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DWITH_CUDA=OFF \
  -DWITH_OPENGL=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.7 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.7) \
  -DPYTHON_INCLUDE_DIR=$(python3.7 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3.7 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
  .. \
&& make install \
&& rm /${OPENCV_VERSION}.zip \
&& rm -r /opencv-${OPENCV_VERSION}
