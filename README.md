# OpenCV + Tensorflow

A [Docker](http://docker.com) file to build images for AMD & ARM devices over a base image based with a minimal installation of [Tensorflow](https://www.tensorflow.org/) an open source software library for numerical computation using data flow graphs.
Over this base will be installed [OpenCV](https://opencv.org/) a library of programming functions mainly aimed at real-time computer vision.

Based on previous work by Eloy Lopez, ver [blog](http://deft.work/tensorflow_for_raspberry) e [repo](https://github.com/DeftWork/tf-opencv).

| Docker Hub | Docker Pulls | Docker Stars | Docker Build | Size/Layers |
| --- | --- | --- | --- | --- |
| [tf-opencv](https://hub.docker.com/r/elswork/tf-opencv "elswork/tf-opencv on Docker Hub") | [![](https://img.shields.io/docker/pulls/elswork/tf-opencv.svg)](https://hub.docker.com/r/elswork/tf-opencv "tf-opencv on Docker Hub") | [![](https://img.shields.io/docker/stars/elswork/tf-opencv.svg)](https://hub.docker.com/r/elswork/tf-opencv "tf-opencv on Docker Hub") | [![](https://img.shields.io/docker/build/elswork/tf-opencv.svg)](https://hub.docker.com/r/elswork/tf-opencv "tf-opencv on Docker Hub") | [![](https://images.microbadger.com/badges/image/elswork/tf-opencv.svg)](https://microbadger.com/images/elswork/tf-opencv "tf-opencv on microbadger.com") |

## Build Instructions

```sh
root@poe:/home/pi/tf# make  
help                           This help.  
build                          Build the container  
tag                            Tag the container  
push                           Push the container  
manifest                       Create an push manifest  
start                          Start the container  
```

## Typical Usage

```sh
docker run -it josemottalopes/tf:arm32v7
```
