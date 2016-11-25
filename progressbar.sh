#!/bin/bash

#
# example:
# 
# curl -s https://gist.githubusercontent.com/song940/332b80f24e7f203987eff11fc6765bd8/raw/progressbar.sh | sh
#

function ProgressBar(){
  let max=$1
  let done=$2
  let left=$max-$done
  let current=($done*100/$max*100)/100

  local fill=$(printf "%${done}s")
  local empty=$(printf "%${left}s")

  printf "\r [${fill// /#}${empty// /-}] ${current}%%"
}

# demo

for i in {1..70}; do
  ProgressBar 70 $i
  sleep 0.1
done

printf "\nFinished!\n"
