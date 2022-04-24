#!/bin/sh

echo "$0 $@ $#"

say_hello(){
	echo "Hello $@ by $2!! ($#)"
}

say_hello "Jackson" "Hong"

