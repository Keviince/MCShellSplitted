#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SAVE_NAME=`cat $RAWDIR/ENV | grep SAVE_NAME | awk '{print $3}'`
cd $PDIR
mkdir -p $PDIR/playerdata
find playerdata/* -ctime +7 -exec rm -f {} \;
cd $SDIR/$SAVE_NAME
mv $PDIR/playerdata/latest.tar.bz $PDIR/playerdata/$(date -r $PDIR/playerdata/latest.tar.bz +%Y-%m-%d-%H-%M).tar.bz
tar -cjf $PDIR/playerdata/latest.tar.bz playerdata stats advancements datapacks
sync
