#!/bin/bash

timestamp=`date '+%s'`

logs=/var/www/devsystem/logs

[ -d $logs ] || mkdir -p $logs

echo $0 $* > $logs/sendmail-$timestamp
cat -  >> $logs/sendmail-$timestamp
