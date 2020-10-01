#!/bin/sh
DIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $DIR/.. && pwd`
tail -1 $DIR/CQFile/exg.txt | grep -E '\-> !!tps|\-> ！！tps'
if [ $? -eq 0 ] ; then
	$RAWDIR/cqsend 正在查询，请稍后……
	RESULT=`$RAWDIR/detail`
	if [ "$RESULT" = "" ] ; then
		RESULT=`$RAWDIR/detail`
	fi
	$RAWDIR/cqsend $RESULT
fi
