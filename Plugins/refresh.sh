#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
tail -1 $PDIR/latest.log | grep "> !!refresh"
if [ $? == 0 ] ; then
	NAME=$( tail -1 $PDIR/latest.log | grep "> !!refresh" | awk '{print $4}' | sed s'/<//g' | sed s'/>//g' )
	sh $RAWDIR/Data/refreshqq.sh
	sh $RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 缓存已刷新\"}"
fi
