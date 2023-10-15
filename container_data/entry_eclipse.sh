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

mkdir -p /data/src
if [ ! -d "/data/src/ct-bot" ]; then
    git clone https://github.com/tsandmann/ct-bot /data/src/ct-bot 
fi
if [ ! -d "/data/src/ct-sim" ]; then
    git clone https://github.com/tsandmann/ct-sim /data/src/ct-sim 
fi
if [ ! -d "/data/.metadata" ]; then
    tar -xzf /opt/workspace.tgz -C /data --no-same-owner
fi
/opt/eclipse/eclipse -data /data; bash

