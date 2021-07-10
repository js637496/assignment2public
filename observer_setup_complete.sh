#/bin/bash

#set up the scan.sh cron job
(
    echo "0 * * * * sudo bash /local/repository/monitor.sh"
) | sudo crontab -u root -
