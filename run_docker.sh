#!/bin/sh

NAME=arima
IMAGE_TAG=cuda10.2-python3.6
IMAGE_NAME=arijun/dl_remote:${IMAGE_TAG}
CONTAINER_NAME=${NAME}_dl_remote
echo ${IMAGE_NAME}
echo ${CONTAINER_NAME}

docker run -it --rm \
    --privileged \
    --gpus all \
    -e DISPLAY=:0 \
    -p 5901:5900 \
    --name $CONTAINER_NAME \
    $IMAGE_NAME \
    zsh -c "screen -S vnc -d -m zsh -c '/root/start_vnc.sh' && zsh"
