#!/bin/sh
DIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $DIR/.. && pwd`
CQ_HOST=`cat $RAWDIR/ENV | grep CQ_HOST | awk '{print $3}'`
QQ_GROUP=`cat $RAWDIR/ENV | grep QQ_GROUP | awk '{print $3}'`
tail -1 $DIR/CQFile/exg.txt | grep -E '\-> !!help|\-> !!帮助|\-> ！！help|\-> ！！帮助'
if [ $? -eq 0 ] ; then
	curl -s "$CQ_HOST/send_group_msg" --data-urlencode "group_id=$QQ_GROUP" --data-urlencode "message=输入!!ip获得服务器地址
输入!!tps查看服务器当前TPS
输入!!list查看服务器在线人数
输入!!ex查看服务器状态
输入!!mc来发送消息到服务器
输入!!day来查看开服天数"
fi
