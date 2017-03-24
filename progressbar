#!/bin/bash

#
# example:
# 
# curl -s https://raw.githubusercontent.com/song940/shell-scripts/master/progressbar.sh | sh
#

function ProgressBar(){
  let max=$1
  let now=$2
  let left=$max-$now
  let current=($now*100/$max*100)/100

  local fill=$(printf "%${now}s")
  local empty=$(printf "%${left}s")

  printf "\r [${fill// /#}${empty// /-}] ${current}%%"
}

# demo

for i in {1..70}; do
  ProgressBar 70 $i
  sleep 0.1
done

printf "\nFinished!\n"
