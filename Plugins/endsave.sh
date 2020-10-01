#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
tail -1 $PDIR/latest.log | grep "has made the advancement \[杀死村民\]"
if [ $? == 0 ] ; then
	NAME=`tail -1 $PDIR/latest.log | grep "has made the advancement \[杀死村民\]" | awk '{print $4}'`
	sh $RAWDIR/cqsend $NAME"杀死了末地公用村民！"
fi
tail -1 $PDIR/latest.log | grep "末影水晶被破坏！"
if [ $? == 0 ] ; then
	sh $RAWDIR/cqsend 末影水晶被破坏！请管理组前往查看！
	sh $RAWDIR/Dependencies/locationlog.sh
	sh $RAWDIR/dobackup playerdata
fi
