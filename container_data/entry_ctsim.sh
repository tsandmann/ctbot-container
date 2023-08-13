#!/bin/sh

# ctbot-container
# Copyright (C) 2023 Timo Sandmann
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

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

if [ ! -f "/data/ct-sim.xml" ]; then
    cp /home/developer/config/ct-sim.xml /data/
fi

java -Dsun.java2d.xrender=false -jar /home/developer/ct-Sim.jar -conf /data/ct-sim.xml; bash

