#!/bin/bash

if [ $# -eq 0 ]; then
    docker build . -t arijun/dl_remote:latest
else
    docker build . -f Dockerfile.$@ -t arijun/dl_remote:$@
fi
