#!/bin/bash

# ctbot-container
# Copyright (C) 2021 Timo Sandmann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

READLINK=greadlink
if ! command -v $READLINK &> /dev/null
then
    READLINK=readlink
    if ! command -v $READLINK &> /dev/null
    then
        echo "Neither readlink nor greadlink found, abort."
        exit
    fi
fi
DATA_PATH=`$READLINK -f ${1:-$HOME/data}`
echo "Using data path $DATA_PATH"
VERSION=${2:-2021-06}
echo "Starting Eclipse version $VERSION"

COMMAND=podman
IDMAP_ARGS="--uidmap 1000:0:1 --uidmap 0:1:999 --uidmap 1001:1001:64535 --gidmap 1000:0:1 --gidmap 0:1:999 --gidmap 1001:1001:64535"
USER_ARGS="${@:3}"
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

$XHOST_CMD +si:localuser:$USER
$COMMAND run --rm -it -v $DATA_PATH:/data -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$X11_DISPLAY --security-opt=label=type:container_runtime_t $IDMAP_ARGS $USER_ARGS docker.io/tsandmann/ctbot-eclipse-rpi:$VERSION
$XHOST_CMD -si:localuser:$USER
