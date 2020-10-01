#!/bin/sh
DIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $DIR/.. && pwd`
tail -1 $DIR/CQFile/exg.txt | grep -E '\-> !!day|\-> ！！day|\-> ！！天数|\-> !!天数'
if [ $? -eq 0 ] ; then
	STARTDATE=`date -d "20160527" +%s`
	NOWDATE=`date +%s`
	TMPDAYS=`expr $NOWDATE - $STARTDATE `
	DAYS=`expr $TMPDAYS / 86400 `
	sh $RAWDIR/cqsend "冒险者大陆服务器当前周目已开启$DAYS天！"
fi
