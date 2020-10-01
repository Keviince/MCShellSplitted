#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
CQ_HOST=`cat $RAWDIR/ENV | grep CQ_HOST | awk '{print $3}'`
QQ_GROUP=`cat $RAWDIR/ENV | grep QQ_GROUP | awk '{print $3}'`
tail -1 $PDIR/latest.log | grep "> !!qq"
if [ $? -eq 0 ] ; then
	CONTENT=$( tail -1 $PDIR/latest.log | grep "> !!qq" | awk '{ for(i=1; i<=5; i++){ $i="" }; print $0 }' | sed 's/"/\"/g' | cut -c 6- )
	NAME=$( tail -1 $PDIR/latest.log | grep "> !!qq" | awk '{print $4}' | sed s'/<//g' | sed s'/>//g' )
	curl -s "$CQ_HOST/send_group_msg" --data-urlencode "group_id=$QQ_GROUP" --data-urlencode "message=$NAME在游戏中说：$CONTENT" >> /dev/null
fi
