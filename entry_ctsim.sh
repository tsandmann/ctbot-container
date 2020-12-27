#!/bin/sh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

if [ ! -f "/data/ct-sim.xml" ]; then
    cp /home/developer/config/ct-sim.xml /data/
fi

java -Dsun.java2d.xrender=false -jar /home/developer/ct-Sim.jar -conf /data/ct-sim.xml; bash

