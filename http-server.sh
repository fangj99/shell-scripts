#!/usr/bin/env bash

#
# HTTP WEB SERVER
# written in pure shell scripts
# 
# @song940
#
response="/tmp/http-server.pipe"
mkfifo $response > /dev/null 2>&1
#
# parse request
#
parse_request(){
  read request
  local request_method=$(echo "$request" | cut -d ' ' -f1)
  local request_path=$(echo "$request" | cut -d ' ' -f2)
  if [ "$request_path" == "/" ]; then
    request_path="/index.html"
  fi
  # logger
  echo "$request"
  # while read request_header; do
  #   echo "$request_header"
  # done
  local filename="$PWD$request_path"
  if [ -f "$filename" ]; then
    if [ -x "$filename" ]; then
      "$filename" > $response 2>&1
    else
      cat "$filename" > $response
    fi
    return
  fi
  echo "Not Found" > $response
}


#
# start_server
#
start_server(){
  local port=$1
  while true; do
    cat $response | nc -l $port > \
    >(parse_request)
  done
  rm -f "$response"
}

start_server 8080