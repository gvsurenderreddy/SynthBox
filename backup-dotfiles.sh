#!/bin/bash

SOURCE=/home/synth/
TARGET=overlay/etc/skel

rsync -rvz --delete $SOURCE $TARGET

