#/bin/bash
sleep 10m

sudo mount 192.168.1.2:/var/webserver_monitor  /var/webserver_log
sudo touch /var/webserver_log/nfs_is_working.txt
crontab -l | { cat; echo "*/5 * * * * sudo bash /local/repository/scan.sh"; } | crontab -
