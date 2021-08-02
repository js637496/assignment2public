#/bin/bash
while [ ! -d /var/webserver_log/nfs_is_working.txt ]; do
  sudo mount 192.168.1.2:/var/webserver_monitor  /var/webserver_log
  sleep 10
done

export EDITOR=nano

sudo su root

(crontab -l && echo "*/5 * * * * test") | crontab -
(crontab -l && echo "*/5 * * * * sudo bash /local/repository/scan.sh") | crontab -
