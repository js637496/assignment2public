#/bin/bash
export EDITOR=nano
#set up the scan.sh cron job

sudo su root

(crontab -l && echo "*/5 * * * * test") | crontab -
(crontab -l && echo "*/10 * * * * sudo bash /local/repository/monitor.sh") | crontab -
