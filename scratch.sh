#/bin/bash

#Getting the last log entry date, make sure we only get logs after this date
#Still some work to do on this part
#lastLog=$(tail -1 /var/webserver_log/unauthorized.log)
echo $lastlog
thetime="17:15:34"
echo $thetime
tnetime=$($thetime | tr --delete :)
echo $thetime
# IFS=' ' read -r -a lastarray <<< "$lastLog"
# prevDateStr=${lastarray[2]}" "${lastarray[3]}" "$thetime
# prevDate=$(date -d $prevDateStr + +%s)
# echo $prevDateStr