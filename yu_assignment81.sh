#!/bin/bash
echo "###########################################"
echo "# ako ngayon ay nag iinstall ng wordpress #"
echo "###########################################"
yum install -y httpd
systemctl restart httpd
firewall-cmd --permanent --add-port 80/tcp --permanent
firewall-cmd --permanent --add-port 443/tcp --permanent
firewall-cmd --reload
yum install -y php php-mysql
systemctl restart httpd.service
yum info-php-fpm
yum install -y phpfpm
cd /var/www/html
cat > info.php <<- EOF
<?php phpinfo(); ?>
EOF
yum install -y mariadb-server mariadb
systemctl start mariadb
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
systemctl enable mariadb

mysqladmin -u root -p$v1 version
echo "CREATE DATABASE wordpress; CREATE USER 
wordpressuser@localhost IDENTIFIED by 'paulyupogi'; GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED by 'paulyupogi'; FLUSH PRIVILEGES; "| mysql -u root -p$v1
yum install -y php-gd
yum install -y tar
yum install -y wget
systemctl restart httpd 
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
yum install -y rsync
rsync -avP wordpress/ /var/www/html/
cd /var/www/html/
mkdir /var/www/html/wp-content/uploads
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
echo "#################################"
echo "# itong proseso ay tapos nag    #"
echo "#ang wordpress ay na install na #"
echo "#################################"