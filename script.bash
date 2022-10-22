#!/usr/bin/env bash


kolvodirect=0
kolvofile=0

f() {kolvodirect=$(expr $kolvodirect + 1)
  local directory=$1
  local pref=$2
  local children=($(ls $directory))
  local child_count=${#children[@]}
  for idx in "${!children[@]}"; do 
    local child="${children[$idx]}"
    local sbefore="│   "
    local symb="├── "
    if [ $idx -eq $(expr ${#children[@]} - 1) ]; then
      symb="└── "
      sbefore="    "
    fi
    echo "${pref}${symb}$child"
    [ -d "$directory/$child" ] &&
      f "$directory/$child" "${pref}$sbefore" ||
      kolvofile=$(expr $kolvofile + 1)
  done}
parent="."
[ "$#" -ne 0 ] && parent="$1"
echo $parent
f $parent ""
echo
echo "$(expr $kolvodirect - 1) directories, $kolvofile files"