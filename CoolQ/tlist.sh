#!/bin/sh
DIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $DIR/.. && pwd`
tail -1 $DIR/CQFile/exg.txt | grep -E '\-> !!tlist|\-> ！！tlist'
if [ $? -eq 0 ] ; then
	LISTRAW=`$RAWDIR/list`
	ONLINE=`echo $LISTRAW | awk '{print $3}'`
	LIST=`echo $LISTRAW | awk '{for(i=10+1;i<=NF;i++)printf $i " ";printf"\n"}' | sed s/[[:space:]]//g | sed 's/,/, /g'`
	sleep 0.1
	TPS=`$RAWDIR/detail tps`
	if [ "$TPS" = "" ] ; then
		TPS=`$RAWDIR/detail tps`
	fi
	$RAWDIR/cqsend 当前有$ONLINE名玩家在线：$LIST，TPS为$TPS/20
fi
