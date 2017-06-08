CREATE DATABASE diploid;

USE diploid;

# mgrpasswd
CREATE USER 'mgr'@'localhost' IDENTIFIED BY 'mgrpasswd';

GRANT ALL PRIVILEGES ON diploid. * TO 'mgr'@'localhost';


FLUSH PRIVILEGES;


mysql -D diploid -u mgr -p 
