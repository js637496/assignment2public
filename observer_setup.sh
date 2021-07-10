#/bin/bash

sudo apt -y install nfs-kernel-server
sudo mkdir -p /var/webserver_monitor
sudo chown -R nobody:nogroup /var/webserver_monitor
sudo chmod 777 /var/webserver_monitor/

sudo echo '/var/webserver_monitor 192.168.1.0/24(rw,sync,no_subtree_check)' | sudo tee -a /etc/exports
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
sudo ufw allow from 192.168.1.0/24 to any port nfs
sudo ufw allow 22
sudo ufw --force enable
sudo ufw status

sudo chmod 755 /local/repository/monitor.sh