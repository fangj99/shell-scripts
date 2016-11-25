#!/usr/bin/env bash
#

response=/tmp/http-server-pipe
mkfifo $response > /dev/null 2>&1

while true; do
  cat $response | nc -l 8080 > >(
    while read line; do
      line=$(echo "$line" | tr -d '[\r\n]')
      # parse http request
      if echo "$line" | grep -qE '^GET /'; then
        # request path
        path=$(echo "$line" | cut -d ' ' -f2)
        if [ "$path" == "/" ]; then 
          path="/index" 
        fi
        # defaults to html files
        path="$PWD$path.html"
        # make http response
        cat $path > $response 2>&1
      fi
    done
  )
done