#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
tail -1 $PDIR/latest.log | grep "> !!time"
if [ $? == 0 ] ; then
	TIME=`date +现在是%Y年%m月%d日%H时%M分`
	$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] $TIME\"}" >> /dev/null
fi
