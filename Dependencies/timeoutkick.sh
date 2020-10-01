#!/bin/sh
DIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $DIR/.. && pwd`
sleep 60
cat $RAWDIR/Data/linkmembers.txt | grep $1 >> /dev/null
if [ $? -eq 0 ] ; then
	exit
else
	$RAWDIR/send kick $1
	exit
fi
