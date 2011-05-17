#!/bin/bash
#when running in a vm, this is for 
#backing up the config to the host machine.

#use virtualbox default gateway
VHOST=10.0.2.2
VHOSTUSER=sean
VHOSTPATH=/home/sean/Temp/synthboxconfig

rsync -avz --del -e ssh /home/synth $VHOSTUSER@$VHOST:$VHOSTPATH
