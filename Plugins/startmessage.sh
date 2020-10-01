#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
CQ_HOST=`cat $RAWDIR/ENV | grep CQ_HOST | awk '{print $3}'`
QQ_GROUP=`cat $RAWDIR/ENV | grep QQ_GROUP | awk '{print $3}'`
tail -1 $PDIR/latest.log | grep "For help, type"
if [ $? -eq 0 ] ; then
	$RAWDIR/cqsend 服务器已开启！
fi
