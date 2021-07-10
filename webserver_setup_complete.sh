#/bin/bash
sleep 10m

sudo mount 192.168.1.2:/var/webserver_monitor  /var/webserver_log
sudo touch /var/webserver_log/nfs_is_working.txt
export EDITOR=nano
#set up the scan.sh cron job
(
    echo "*/5 * * * * sudo bash /local/repository/scan.sh"
) | sudo crontab -u root -
