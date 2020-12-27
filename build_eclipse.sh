#!/bin/bash
VERSION=${1:-2020-12}

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

$COMMAND build -t ctbot-eclipse:$VERSION -f ./Dockerfile.eclipse --build-arg version=$VERSION .

