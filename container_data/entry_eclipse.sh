#!/bin/sh
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

