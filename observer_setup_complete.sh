#/bin/bash
export EDITOR=nano
#set up the scan.sh cron job

crontab -l | { cat; echo "0 * * * * sudo bash /local/repository/monitor.sh"; } | crontab -
