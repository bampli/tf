ARG BASEIMAGE=josemottalopes/os-py:armv71
FROM ${BASEIMAGE}

# ARG BUILD_DATE
# ARG VCS_REF
# ARG VERSION
# ARG TFVERSION
# LABEL mantainer="Jose Motta <josemotta@bampli.com>" \
#     org.label-schema.build-date=$BUILD_DATE \
#     org.label-schema.name="tf" \
#     org.label-schema.description="Tensorflow-Python3.7" \
#     org.label-schema.url="https://bampli.com" \
#     org.label-schema.vcs-ref=$VCS_REF \
#     org.label-schema.vcs-url="https://github.com/bampli/tf" \
#     org.label-schema.vendor="bAmpli" \
#     org.label-schema.version=$VERSION \
#     org.label-schema.schema-version="0.1"

#      python3-dev python3-pip python3-h5py \
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#       libatlas-base-dev \
#       python3-pip python3-h5py \
#       build-essential cmake git wget unzip yasm pkg-config \
#       libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev \
#       libavformat-dev libpq-dev \
#       libssl-dev openssl libffi-dev && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

ARG WHL_FILE=tensorflow==$TFVERSION
RUN python3.7 -m pip install --upgrade pip setuptools && \
    pip3 --no-cache-dir install --target=/usr/local/bin --upgrade $WHL_FILE 
