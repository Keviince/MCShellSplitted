#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
tail -1 $PDIR/latest.log | grep "> !!day"
if [ $? == 0 ] ; then
	STARTDATE=`date -d "20160527" +%s`
	NOWDATE=`date +%s`
	TMPDAYS=`expr $NOWDATE - $STARTDATE `
	DAYS=`expr $TMPDAYS / 86400 `
	$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 冒险者大陆服务器已开启$DAYS天！\"}" >> /dev/null
fi
