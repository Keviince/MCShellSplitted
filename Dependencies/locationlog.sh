#!/bin/sh
PDIR=$( cd "$( dirname "$0" )" && pwd )
RAWDIR=`cd $PDIR/.. && pwd`
cd $RAWDIR/Backup/location
date +[%H:%M:%S] >> $(date +%Y-%m-%d).log
sh $RAWDIR/location all >> $(date +%Y-%m-%d).log
