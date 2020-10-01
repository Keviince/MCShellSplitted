#!/bin/sh
DIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $DIR/.. && pwd`
CQ_HOST=`cat $RAWDIR/ENV | grep CQ_HOST | awk '{print $3}'`
QQ_GROUP=`cat $RAWDIR/ENV | grep QQ_GROUP | awk '{print $3}'`
tail -1 $DIR/CQFile/exg.txt | grep -E '\-> !!ip|\-> !!地址|\-> ！！ip|\-> ！！地址'
if [ $? -eq 0 ] ; then
	curl -s "$CQ_HOST/send_group_msg" --data-urlencode "group_id=$QQ_GROUP" --data-urlencode "message=主线地址：ex.topo.world
备用地址一：node1.ex.topo.world（联通单线）
备用地址二：node2.ex.topo.world（杭州BGP）
备用地址三：node3.ex.topo.world（上海BGP）"
fi
