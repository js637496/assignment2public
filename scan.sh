#/bin/bash

#Getting the last log entry date, make sure we only get logs after this date
#Still some work to do on this part
lastLog=$(tail -1 /var/webserver_log/unauthorized.log)
echo $lastlog
IFS=' ' read -r -a lastarray <<< "$lastLog"
prevDateStr=${lastarray[2]}" "${lastarray[3]}" "${lastarray[4]}" "${lastarray[5]}
echo $prevDateStr
prevDate=$(date -d $prevDateStr + +%s)
echo $prevDate


while read line
do
	DATE=""
	IP_ADDRESS=""
	array=""
	#echo $line
	IFS=' ' read -r -a array <<< "$line"
	for index in "${!array[@]}"
	do
		if [[ "$index" -lt 3 ]]
		then
			if [[ "$index" -eq 2 ]]
			then
				year=$(date +"%Y")
				DATE+=$year" "
			fi
			DATE+=${array[index]}" "
		fi
		echo $DATE

		if [[ "${array[index]}" == "port" ]]
		then
			before="$((index-1))"
			IP_ADDRESS=${array[before]}
		fi		
	done
	#TODO check i9f date is after last date in log, otherwise skip
	COUNTRY=$(whois $IP_ADDRESS |grep country -i -m 1 |cut -d ':' -f 2 |xargs)
	logLine=$IP_ADDRESS" "$COUNTRY" "$DATE
	echo $logLine >> /var/webserver_log/unauthorized.log
done < <(sudo grep sshd\\[[0-9].\*Failed /var/log/auth.log)
