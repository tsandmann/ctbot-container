#!/bin/bash
VERSION=${1:-2.28}

COMMAND=podman
if ! command -v $COMMAND &> /dev/null
then
    COMMAND=docker
    if ! command -v $COMMAND &> /dev/null
    then
        echo "Neither podman nor docker found, abort."
	exit
    fi
    
    echo "podman not found, will use docker."
fi

$COMMAND build -t ctsim:$VERSION -f ./Dockerfile.ctsim --build-arg version=$VERSION .
$COMMAND build -t ctsim-dev -f ./Dockerfile.ctsim-dev --build-arg version=develop .

