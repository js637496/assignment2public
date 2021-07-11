#/bin/bash

#Getting the last log entry date, make sure we only get logs after this date
#Still some work to do on this part
lastLog=$(tail -1 /var/webserver_log/unauthorized.log)
IFS=' ' read -r -a lastarray <<< "$lastLog"
prevDateStr=${lastarray[2]}" "${lastarray[3]}" "${lastarray[4]}" "${lastarray[5]}
prevDate=$(date --date="$prevDateStr" +%s)

while read line
do
	DATE=""
	IP_ADDRESS=""
	array=""
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

		if [[ "${array[index]}" == "port" ]]
		then
			before="$((index-1))"
			IP_ADDRESS=${array[before]}
		fi		
	done

	currentDate=$(date --date="$DATE" +%s)
	if [[ $currentDate -gt $prevDate ]]
	then
		COUNTRY=$(whois $IP_ADDRESS | grep country -i -m 1 |cut -d ':' -f 2 | cut -c1-2 |xargs)
		logLine=$IP_ADDRESS" "$COUNTRY" "$DATE
		sudo echo "$logLine" | sudo tee -a /var/webserver_log/unauthorized.log
	fi
done < <(sudo grep sshd\\[[0-9].\*Failed /var/log/auth.log)
