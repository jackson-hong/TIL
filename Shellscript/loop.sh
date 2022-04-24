#!/bin/bash

for i in `ls`
do
	echo " --------- $i "
	cat $i
	echo "=========================="
done

