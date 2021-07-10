#/bin/bash
sleep 3m

sudo mount 192.168.1.2:/var/webserver_monitor  /var/webserver_log
sudo touch /var/webserver_log/nfs_is_working.txt

#set up the scan.sh cron job
(
    echo "*/5 * * * * /local/repository/scan.sh"
) | crontab -u root -
