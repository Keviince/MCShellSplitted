#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
QQ_GROUP=`cat $RAWDIR/ENV | grep QQ_GROUP | awk '{print $3}'`
tail -1 $PDIR/latest.log | grep "> !!link"
if [ $? == 0 ] ; then
	NAME=$( tail -1 $PDIR/latest.log | grep "> !!link" | awk '{print $4}' | sed s'/<//g' | sed s'/>//g' )
	QQNUM=$( tail -1 $PDIR/latest.log | grep "> !!link" | awk '{print $6}' )
	if [ "$NAME" = "" ] ; then
		exit
	fi
	if [ "$QQNUM" = "" ] ; then
		$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入\\\"!!link+空格+你的QQ号\\\"来绑定你的QQ号到游戏ID\"}" >> /dev/null
		exit
	fi
	grep -r $NAME $RAWDIR/Data/linkmembers.txt
	if [ $? == 0 ] ; then
		sed -i '/'${NAME}'/d' $RAWDIR/Data/linkmembers.txt
		$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 你已更改已绑定的QQ号\"}" >> /dev/null
		echo "$NAME $QQNUM" >> $RAWDIR/Data/linkmembers.txt
		exit
	fi
	grep -r $QQNUM $RAWDIR/Data/groupmembers.txt
	if [ $? == 0 ] ; then
		echo "$NAME $QQNUM" >> $RAWDIR/Data/linkmembers.txt
		$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 你已绑定你的QQ号\"}" >> /dev/null
	else
		$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 你还没有加入我们的官方群！请加入$QQ_GROUP\"}" >> /dev/null
		$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 如果你已加入，请输入!!refresh来刷新缓存\"}" >> /dev/null
	fi
fi
