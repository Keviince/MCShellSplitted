#!/bin/sh
DIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $DIR/.. && pwd`
tail -1 $DIR/CQFile/exg.txt | grep -E '\-> !!mc |\-> ！！mc '
if [ $? -eq 0 ] ; then
	QQNUM=`tail -1 $DIR/CQFile/exg.txt | grep -E '\-> !!mc |\-> ！！mc ' | awk '{print $3}'`
	grep -r $QQNUM $RAWDIR/Data/linkmembers.txt >> /dev/null
	if [ $? == 0 ] ; then
		NAME=`grep -r $QQNUM $RAWDIR/Data/linkmembers.txt | head -1 | awk '{print $1}'`
	else
		$RAWDIR/cqsend "请在服务器内输入\"!!link 你的QQ号\"来绑定你的游戏账号"
		exit
	fi
	COMMENT=`tail -1 $DIR/CQFile/exg.txt | grep -E '\-> !!mc |\-> ！！mc ' | awk '{$1="";$2="";$3="";$4="";print $0}' | sed 's/^[ \t]*//g'`
	$RAWDIR/send "tellraw @a {\"text\":\"<$NAME(QQ)> $COMMENT\"}"
fi
