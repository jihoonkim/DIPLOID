# install MariaDB package 
sudo yum install mariadb-server

# start a daemon
sudo systemctl start mariadb

# ensure that MariaDB starts at boot, 
sudo systemctl enable mariadb


# change datadir
vi /etc/my.cnf

#datadir=/var/lib/mysql
#datadir=/scratch/mysql 

mkdir -p /scratch/mysql
chown mysql:mysql /scratch/mysql