#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SAVE_NAME=`cat $RAWDIR/ENV | grep SAVE_NAME | awk '{print $3}'`
cd $SDIR
mkdir -p $PDIR/day
mv $PDIR/day/latest.tar.bz $PDIR/day/$(date -r $PDIR/day/latest.tar.bz +%Y-%m-%d-%H-%M).tar.bz
pushd $SDIR/$SAVE_NAME
tar -cjvf $PDIR/day/latest.tar.bz -T $PDIR/daybacklist.txt >> /dev/null
popd
