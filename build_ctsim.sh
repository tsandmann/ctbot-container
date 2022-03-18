#!/bin/bash

# ctbot-container
# Copyright (C) 2022 Timo Sandmann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

VERSION=${1:-2.29.1}
USER_ARGS="${@:2}"

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

$COMMAND build -t ctsim:$VERSION -t docker.io/tsandmann/ctsim:$VERSION -t docker.io/tsandmann/ctsim:latest -f ./Dockerfile.ctsim --build-arg version=$VERSION $USER_ARGS .
$COMMAND build -t ctsim-dev -t docker.io/tsandmann/ctsim-dev -f ./Dockerfile.ctsim-dev --build-arg version=develop --build-arg base_version=$VERSION $USER_ARGS .

