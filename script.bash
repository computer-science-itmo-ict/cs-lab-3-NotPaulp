#!/usr/bin/env bash
export LANG=en_US.UTF-8
kolvodirect=0
kolvofile=0
f() {
  kolvodirect=$(expr $kolvodirect + 1)
  local directory=$1
  local pref=$2
  local children=($(ls $directory))
  local child_count=${#children[@]}
  for i in "${!children[@]}"; do 
    local child="${children[$i]}"
    local sbefore="│   "
    local symb="├── "
    if [ $i -eq $(expr ${#children[@]} - 1) ]; then
      symb="└── "
      sbefore="    "
    fi
    echo "${pref}${symb}$child"
    [ -d "$directory/$child" ] &&
      f "$directory/$child" "${pref}$sbefore" ||
      kolvofile=$(expr $kolvofile + 1)
  done
}
parent=$@
if [ parent=='' ]; then
parent='.'
fi
[ "$#" -ne 0 ] && parent="$1"
echo $parent
f $parent ""
echo
kolvodirect=$(expr $kolvodirect - 1)
if [[ $kolvodirect -eq 1 ]]
then
answerdir='directory'
else
answerdir='directories'
fi
if [[ $kolvofile -eq 1 ]]
then
answerfile='file'
else
answerfile='files'
fi
echo "$kolvodirect $answerdir, $kolvofile $answerfile"
