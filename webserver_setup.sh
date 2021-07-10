#/bin/bash

sudo apt -y install apache2
sudo apt -y install whois

#allow password ssh
sudo mv /local/repository/sshd_config /etc/ssh/sshd_config
sudo echo 'PasswordAuthentication yes' | sudo tee -a /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo apt -y install nfs-common
#Can not mount until nfs server is up and running
sudo mkdir -p /var/webserver_log
sudo chmod 755 /local/repository/scan.sh