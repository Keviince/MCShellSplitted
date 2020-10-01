#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SAVE_NAME=`cat $RAWDIR/ENV | grep SAVE_NAME | awk '{print $3}'`
cd $SDIR
mkdir -p $PDIR/month
mv $PDIR/month/latest.tar.bz $PDIR/month/$(date -r $PDIR/month/latest.tar.bz +%Y-%m-%d-%H-%M).tar.bz
tar -cjvf $PDIR/month/latest.tar.bz $SDIR/$SAVE_NAME >> /dev/null
