#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
BDIR=`cd $RAWDIR/Backup && pwd`
JAVA_VAR=`cat $RAWDIR/ENV | grep JAVA_VAR | awk '{ $1="" ; $2="" ; print $0 }' | sed 's/^.//'`
echo "Entering Server Loop ......"
cd $SDIR
rm -f .STOP
while true
do
	$JAVA_VAR
	echo "Server Stopped."
	#创建一个在服务器重启或关闭时被运行并随后被清空的可执行文件，以便进行热修复等操作
	$PDIR/stopevent.sh
	echo "#!/bin/sh" > $PDIR/stopevent.sh
	echo "# 此脚本会在服务器重启或关闭时被运行并随后被清空" >> $PDIR/stopevent.sh
	echo "# This Script Will Be Run And Cleared After A Stop Or Restart Operation" >> $PDIR/stopevent.sh
	chmod +x $PDIR/stopevent.sh
	mkdir -p $BDIR/hotfix/region
	mkdir -p $BDIR/hotfix/playerdata
	mkdir -p $BDIR/hotfix/stats
	mkdir -p $BDIR/hotfix/advancements
	mkdir -p $BDIR/hotfix/data
	mkdir -p $BDIR/hotfix/DIM1/region
	mkdir -p $BDIR/hotfix/DIM-1/region
	if [ -f .STOP ]; then
		exit
	fi
	echo "Server Will Restart In 3 Sec"
	sleep 1
	echo "Server Will Restart In 2 Sec"
	sleep 1
	echo "Server Will Restart In 1 Sec"
	sleep 1
done
	
