#!/bin/bash
echo "###########################################"
echo "# ako ngayon ay nag iinstall ng wordpress #"
echo "###########################################"
#first we need to install Apache httpd
yum install -y httpd
#then restart the apache
systemctl restart httpd
#checking if the apche web server is running
systemctl status httpd
#now we need to set the firewalld to alllow the traffic to our webserver
firewall-cmd --permanent --add-port 80/tcp --permanent
firewall-cmd --permanent --add-port 443/tcp --permanent
#and then reload the firewall
firewall-cmd --reload
#now we need to install php that will process the code to display dynamic content
yum install -y php php-mysql
#then we need to restart the apche web server in order to proccess the php.
systemctl restart httpd.service
yum info-php-fpm
#install the phpfpm
yum install -y phpfpm
cd /var/www/html
#this will open a blank file then input the text info.php
cat > info.php <<- EOF
<?php phpinfo(); ?>
EOF
#now we should install mariadb
yum install -y mariadb-server mariadb
#start the mariadb 
systemctl start mariadb
#checking if the mariadb is running
systemctl status mariadb
mysql_secure_installation <<EOF

y
paulyupogi
paulyupogi
y
y
y
y
EOF

v1=paulyupogi
#enable command is to start the mariadb automatically when the vm starts
systemctl enable mariadb

mysqladmin -u root -p$v1 version
echo "CREATE DATABASE wordpress; CREATE USER 
wordpressuser@localhost IDENTIFIED by 'paulyupogi'; GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED by 'paulyupogi'; FLUSH PRIVILEGES; "| mysql -u root -p$v1
#we need to install the following tools
yum install -y php-gd
yum install -y tar
yum install -y wget
#then restart the apche web server
systemctl restart httpd 
#now we use the wget to get the wordpress
wget http://wordpress.org/latest.tar.gz
#this will install all the archive files with wordpress files
tar xzvf latest.tar.gz
#now we need to install the rsync tool
yum install -y rsync
#now we need to have a directory called wordpress in home directory and transfer all wordpress files there
rsync -avP wordpress/ /var/www/html/
cd /var/www/html/
mkdir /var/www/html/wp-content/uploads
#then we need to assign the correct ownerships and permission
chown -R apache:apache /var/www/html/*
cp wp-config-sample.php wp-config.php
cd /var/www/html/
sed -i 's/database_name_here/wordpress/g' wp-config.php
sed -i 's/username_here/wordpressuser/g' wp-config.php
sed -i 's/password_here/paulyupogi/g' wp-config.php
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y yum-utils
yum-config-manager --enable remi-php56 
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
systemctl restart httpd
echo "##################################"
echo "# itong proseso ay tapos na      #"
echo "# ang wordpress ay na install na #"
echo "##################################"