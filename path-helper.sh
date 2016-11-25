#!/usr/bin/env bash

# auto load PATH config from /etc/path.d/*
# 
# https://gist.github.com/song940/af1c300890ca1024fa60

PATH_DIR=/etc/path.d

for file in $(ls $PATH_DIR); do
  for line in $(cat "$PATH_DIR/$file"); do
    PATH=$PATH:$line
  done
done

export PATH