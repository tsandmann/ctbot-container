#!/bin/bash
DATA_PATH=${1:-$HOME/data}
VERSION=${2:-2.28}

COMMAND=podman
IDMAP_ARGS="--uidmap 1000:0:1 --uidmap 0:1:999 --uidmap 1001:1001:64535 --gidmap 1000:0:1 --gidmap 0:1:999 --gidmap 1001:1001:64535"
USER_ARGS="${@:2}"
X11_DISPLAY="unix$DISPLAY"
XHOST_CMD="xhost"

if ! command -v $COMMAND &> /dev/null
then
    COMMAND=docker
    if ! command -v $COMMAND &> /dev/null
    then
        echo "Neither podman nor docker found, abort."
    exit
    fi

    IDMAP_ARGS="" 
    echo "podman not found, will use docker."
fi

if [[ ! -z "$WSL_DISTRO_NAME" ]]; then
    echo "WSL detected, make sure to have an X Server (like VcXsrv) running on your Windows host."
    X11_DISPLAY="host.docker.internal:0"
    XHOST_CMD="true"
fi

if [[ $OSTYPE == *"darwin"* ]]; then
    echo "macOS detected, make sure to have an X Server (like XQuartz) running on your macOS host."
    X11_DISPLAY="docker.for.mac.host.internal:0"
    XHOST_CMD="true"
fi

$XHOST_CMD +si:localuser:$USER
$COMMAND run --rm -it -v $DATA_PATH:/data -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$X11_DISPLAY --security-opt=label=type:container_runtime_t -p 10001:10001 $IDMAP_ARGS $USER_ARGS docker.io/tsandmann/ctsim:$VERSION
$XHOST_CMD -si:localuser:$USER
