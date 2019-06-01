SNAME ?= tf
NAME ?= josemottalopes/$(SNAME)
VER ?= `cat VERSION-TF`-`cat VERSION-OCV`
TFVERSION ?= `cat VERSION-TF`
ARCH2 ?= armv7l
PLATFORM := $(shell uname -m)
ifeq ($(PLATFORM),x86_64)
	PLATFORM := amd64
	BASENAME ?= ubuntu:16.04
endif
ifeq ($(PLATFORM),armv7l)
	BASENAME ?= arm32v7/debian:stretch-slim
endif

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build the container
	docker build --no-cache -t $(NAME):$(PLATFORM) \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg TFVERSION=$(TFVERSION) \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(SNAME)_$(PLATFORM)_$(VER) \
	. > ../builds/$(SNAME)_$(PLATFORM)_$(VER)_`date +"%Y%m%d_%H%M%S"`.txt
tag: ## Tag the container
	docker tag $(NAME):$(PLATFORM) $(NAME):$(PLATFORM)_$(VER)
push: ## Push the container
	docker push $(NAME):$(PLATFORM)_$(VER)
	docker push $(NAME):$(PLATFORM)	
deploy: build tag push
manifest: ## Create and push manifest
	docker manifest create $(NAME):$(VER) $(NAME):$(PLATFORM)_$(VER) $(NAME):$(ARCH2)_$(VER)
	docker manifest push --purge $(NAME):$(VER)
	docker manifest create $(NAME):latest $(NAME):$(PLATFORM) $(NAME):$(ARCH2)
	docker manifest push --purge $(NAME):latest
start: ## Start the container
	docker run -it $(NAME):$(PLATFORM)
test1: 
	docker run -it --rm $(NAME):$(PLATFORM) \
	python3.7 -c "import tensorflow as tf; print(tf.__version__)"
test2: 
	docker run -it --rm $(NAME):$(PLATFORM) \
	python3.7 -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"
# test3: 
# 	docker run -it --rm $(NAME):$(PLATFORM) \
# 	python3.7 -c "import cv2; cv2.__version__"
