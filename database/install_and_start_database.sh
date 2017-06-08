# install MariaDB package 
sudo yum install mariadb-server

# start a daemon
sudo systemctl start mariadb

# ensure that MariaDB starts at boot, 
sudo systemctl enable mariadb