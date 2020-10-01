#!/bin/sh
DIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $DIR/.. && pwd`
CQ_HOST=`cat $RAWDIR/ENV | grep CQ_HOST | awk '{print $3}'`
QQ_GROUP=`cat $RAWDIR/ENV | grep QQ_GROUP | awk '{print $3}'`
tail -1 $DIR/CQFile/exg.txt | grep "\-> \!\!ex"
if [ $? -eq 0 ] ; then
	LISTRAW=`sh $RAWDIR/list`
	NUM=`echo $LISTRAW | awk '{print $3}'`
	LIST=`echo $LISTRAW | awk '{for(i=10+1;i<=NF;i++)printf $i " ";printf"\n"}'`
	VER=`cat $RAWDIR/Server/logs/latest.log | grep "Starting minecraft server version" | awk '{print $NF}'`
	curl -s "$CQ_HOST/send_group_msg" --data-urlencode "group_id=$QQ_GROUP" --data-urlencode "message=欢迎来到冒险者大陆服务器！
当前服务器版本为：$VER
当前在线人数为：$NUM/50
当前在线玩家为：$LIST"
fi
