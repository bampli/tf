ARG BASEIMAGE=arm32v7/debian:stretch-slim
FROM ${BASEIMAGE}

# ARG BUILD_DATE
# ARG VCS_REF
# ARG VERSION
# ARG TFVERSION
# LABEL mantainer="Jose Motta <josemotta@bampli.com>" \
#     org.label-schema.build-date=$BUILD_DATE \
#     org.label-schema.name="tf" \
#     org.label-schema.description="OpenCV-Tensorflow-Python3.7:arm32v7" \
#     org.label-schema.url="https://bampli.com" \
#     org.label-schema.vcs-ref=$VCS_REF \
#     org.label-schema.vcs-url="https://github.com/bampli/tf" \
#     org.label-schema.vendor="bAmpli" \
#     org.label-schema.version=$VERSION \
#     org.label-schema.schema-version="0.1"

ARG TF_WHL="https://github.com/lhelontra/tensorflow-on-arm/releases/download/v1.9.0/tensorflow-1.9.0-cp35-none-linux_armv7l.whl"
ARG TF="tensorflow-1.9.0-cp35-none-linux_armv7l.whl"

WORKDIR /
RUN apt-get update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get install libatlas-base-dev

RUN mkdir ~/downloads && \
    cd ~/downloads && \
    wget $TF_WHL && \
    pip3 install $TF 

