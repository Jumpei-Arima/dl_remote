#!/bin/sh

TAG=cuda10.2-python3.6

if [ $# -eq 0 ]; then
    docker build . -t arijun/dl_remote:${TAG}
else
    docker build . -f Dockerfile.$@ -t arijun/dl_remote:$@
fi
