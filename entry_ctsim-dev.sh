#!/bin/sh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

BRANCH=${1:-develop}
echo "using branch $BRANCH"

mkdir -p /data/src
if [ ! -d "/data/src/ct-sim" ]; then
    git clone --branch $BRANCH https://github.com/tsandmann/ct-sim /data/src/ct-sim
    cd /data/src/ct-sim && ant -f make-jar.xml
fi
cd /data/src/ct-sim && git fetch
if [ `git rev-list HEAD...origin/$BRANCH --count` != 0 ]; then
    git clean -dfx
    git pull
    ant -f make-jar.xml
fi
if [ ! -f "/data/src/ct-sim/bin/build-jar/ct-Sim.jar" ]; then
    ant -f make-jar.xml
fi
java -Dsun.java2d.xrender=false -jar /data/src/ct-sim/bin/build-jar/ct-Sim.jar -conf /data/src/ct-sim/config/ct-sim.xml; bash

