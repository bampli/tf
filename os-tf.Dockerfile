ARG BASEIMAGE=josemottalopes/os-py:latest
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

# RUN mkdir -p $HOME/.config/pip && \
#     touch $HOME/.config/pip/pip.conf && \
#     echo "[global]" >> $HOME/.config/pip/pip.conf && \
#     echo "extra-index-url=https://www.piwheels.org/simple" >> $HOME/.config/pip/pip.conf

# ARG H5PY="https://files.pythonhosted.org/packages/43/27/a6e7dcb8ae20a4dbf3725321058923fec262b6f7835179d78ccc8d98deec/h5py-2.9.0.tar.gz"
# RUN pip3 install -v --no-binary=h5py --target=/usr/local/bin --upgrade-strategy=only-if-needed $H5PY

ARG WHL_FILE=tensorflow==1.13.1
RUN python3 -m pip install --upgrade pip setuptools && \
    pip3 --no-cache-dir install --target=/usr/local --upgrade-strategy=only-if-needed $WHL_FILE 
