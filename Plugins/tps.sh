#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
tail -1 $PDIR/latest.log | grep "> !!tps"
if [ $? == 0 ] ; then
	$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 正在查询，请稍后……\"}" >> /dev/null
	TPS=`$RAWDIR/detail`
	$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] $TPS\"}" >> /dev/null
fi
