#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
tail -1 $SDIR/logs/latest.log | grep "has made the advancement" >> $RAWDIR/Backup/advancement/$(date +%Y-%m-%d).txt
