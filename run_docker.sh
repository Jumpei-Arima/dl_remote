#!/bin/bash

NAME=arima
IMAGE_TAG=latest
IMAGE_NAME=arijun/dl_remote:${IMAGE_TAG}
CONTAINER_NAME=${NAME}_dl_remote
echo ${IMAGE_NAME}
echo ${CONTAINER_NAME}

docker run -it --rm \
    --privileged \
    --gpu all \
    -p 5900:5900 \
    --name $CONTAINER_NAME \
    $IMAGE_NAME \
    zsh
