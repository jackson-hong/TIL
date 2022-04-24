#!/bin/bash

arr=("aaa" "bbb" "ccc" 123)

echo "arr=$arr"
echo "arr=${arr[1]}"
echo ${arr[1]}

len=${#arr[@]}
arr[4]="123456"

echo ${arr[@]}
echo "#### ${#arr} : ${#arr[@]}"
