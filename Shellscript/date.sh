#!/bin/bash

DATE=`date +%Y%m%d`
FN="${DATE}.txt"
echo "mv $1 $FN"
mv $1 $FN
