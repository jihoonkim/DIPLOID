CREATE DATABASE diploid;

USE diploid;

# database manater
CREATE USER 'mgr'@'localhost' IDENTIFIED BY 'mgrpasswd';
GRANT ALL PRIVILEGES ON diploid. * TO 'mgr'@'localhost';
GRANT FILE ON *.* to 'mgr'@'localhost';
FLUSH PRIVILEGES;


# database user
CREATE USER 'caddy'@'localhost' IDENTIFIED BY 'actri';
GRANT ALL PRIVILEGES ON diploid. * TO 'mgr'@'localhost';
GRANT FILE ON *.* to 'caddy'@'localhost';
FLUSH PRIVILEGES;



mysql -D diploid -u mgr -p 
