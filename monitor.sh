#/bin/bash

ADMIN_EMAIL="jimspeers.speers@gmail.com"
ONE_HOUR_AGO=$(date --date='1 hour ago' +%s)

message=""

while read line; do
    IFS=' ' read -r -a lastarray <<< "$line"
    prevDateStr=${lastarray[2]}" "${lastarray[3]}" "${lastarray[4]}" "${lastarray[5]}
    prevDate=$(date --date="$prevDateStr" +%s)
    if [[ $prevDate -gt $ONE_HOUR_AGO ]]
    then
        message+="$line
        "
    fi
done </var/webserver_monitor/unauthorized.log

if [[ $message == "" ]]
then
    message="No unauthorized access."
fi
DATE_NOW=$(date)
sudo mail -s "Unauthorized Access Report - $DATE_NOW" $ADMIN_EMAIL <<< "$message"