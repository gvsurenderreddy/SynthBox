#!/bin/bash

#This file is only to be used if you don't like the default user account
#and you want to add your own default setup.

#Edit these to fit your machine.  You'll have to make a user
#account and customize it (test it: log in as the user!) first.

SOURCE=/home/synth/
TARGET=overlay/etc/skel

if [ -d "$SOURCE" ]; then
  rsync -rvz --delete $SOURCE $TARGET
else
  echo "You need to set up a user account to customize and copy to"
  echo "the live image.  If you already did this, you need to"
  echo "correctly specify the location of that user's home folder in"
  echo "the file 'backup-dotfiles.sh'."
  exit 1
fi

