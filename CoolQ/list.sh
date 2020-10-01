#!/bin/sh
DIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $DIR/.. && pwd`
if [ "$1" = "tps" ] ; then
	LISTRAW=`sh $RAWDIR/list`
	NUM=`echo $LISTRAW | awk '{print $3}'`
	LIST=`echo $LISTRAW | awk '{for(i=9+1;i<=NF;i++)printf $i " ";printf"\n"}' | sed s/[[:space:]]//g | sed 's/,/, /g'`
	$RAWDIR/cqsend 当前有$NUM名玩家在线：$LIST
fi
tail -1 $DIR/CQFile/exg.txt | grep -E '\-> !!list|\-> ！！列表|\-> ！！list|\-> !!列表'
if [ $? -eq 0 ] ; then
	LISTRAW=`sh $RAWDIR/list`
	NUM=`echo $LISTRAW | awk '{print $3}'`
	LIST=`echo $LISTRAW | awk '{for(i=10+1;i<=NF;i++)printf $i " ";printf"\n"}' | sed s/[[:space:]]//g | sed 's/,/, /g'`
	$RAWDIR/cqsend 当前有$NUM名玩家在线：$LIST
fi
