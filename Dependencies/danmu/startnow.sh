#!/bin/bash
DIR=$( cd "$( dirname "$0" )" && pwd )
while true
do
	cd $DIR
	/usr/local/go/bin/go run $DIR/main.go -id $1 >> $DIR/logs/$1.log
done
