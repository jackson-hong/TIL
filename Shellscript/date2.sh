#!/bin/bash

DATE=`date +%Y-%m-%d`

echo $DATE

DATE=`date +%Y-%m-%d --date=yesterday`
DATE=`date +%Y-%m-%d --date='1 day ago'`
DATE=`date +%Y-%m-%d --date='2 day ago'`
DATE=`date +%Y-%m-%d --date='2 day'`
DATE=`date +%Y-%m-%d --date='1 week ago'`
DATE=`date +%Y-%m-%d --date='1 month ago'`
