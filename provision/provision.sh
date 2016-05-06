#!/bin/bash

set -e
set -x

cd /vagrant/provision

# Configure APT
sed -i  s/us.archive/de.archive/  /etc/apt/sources.list
apt-get update
apt-get install -y squid-deb-proxy-client

# Add some useful packages
apt-get install -y vim

# Add packages for 50PlusTreff
apt-get install -y imagemagick

# Add packages for overlayfs
#apt-get install -y overlayroot


# Configure web server directory structure
[ -d /var/www/devsystem            ] || mkdir /var/www/devsystem
[ -d /var/www/devsystem/htdocs     ] || mkdir /var/www/devsystem/htdocs

# Redirect writes into htdocs to htdocs-writes, which is log/htdocs on the host
cp init-overlayfs /etc/init.d/overlayfs
chmod a+x /etc/init.d/overlayfs
[ -f /etc/rc0.d/K02overlayfs ] || ln -s /etc/init.d/overlayfs /etc/rc0.d/K02overlayfs
[ -f /etc/rc1.d/K02overlayfs ] || ln -s /etc/init.d/overlayfs /etc/rc1.d/K02overlayfs
[ -f /etc/rc2.d/S02overlayfs ] || ln -s /etc/init.d/overlayfs /etc/rc2.d/S02overlayfs
[ -f /etc/rc3.d/S02overlayfs ] || ln -s /etc/init.d/overlayfs /etc/rc3.d/S02overlayfs
[ -f /etc/rc4.d/S02overlayfs ] || ln -s /etc/init.d/overlayfs /etc/rc4.d/S02overlayfs
[ -f /etc/rc5.d/S02overlayfs ] || ln -s /etc/init.d/overlayfs /etc/rc5.d/S02overlayfs
[ -f /etc/rc6.d/K02overlayfs ] || ln -s /etc/init.d/overlayfs /etc/rc6.d/K02overlayfs

# Configure Fake Sendmail
cp sendmail-fake.sh /usr/sbin/sendmail
chmod a+x /usr/sbin/sendmail

# Configure MySQL
mysql_password=mysql
debconf-set-selections <<< "mysql-server mysql-server/root_password       password $mysql_password"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysql_password"

apt-get install -y mysql-server
# Make MySQL available to Vagrant host
cat > /etc/mysql/conf.d/vagrant.cnf << EOF
[mysqld]
bind-address		= 0.0.0.0
EOF
/etc/init.d/mysql restart
bash init-mysql.sh



# Configure Apache
apt-get install -y apache2
apt-get install -y php5
apt-get install -y php5-xdebug
apt-get install -y php5-gd
apt-get install -y php5-mysql
apt-get install -y php5-curl
updatedb

# Enable PHP Remote Debugging
cat - > /etc/php5/mods-available/xdebug.ini << EOF
zend_extension=$(locate xdebug.so)
xdebug.remote_enable = on
xdebug.remote_connect_back = on
xdebug.idekey = "Vagrant"
xdebug.remote_port = 9000
EOF

# Fix the cookie problem in PHP
sed -i 's/session.hash_bits_per_character = 5/session.hash_bits_per_character = 4/' /etc/php5/apache2/php.ini

rm -f /etc/apache2/sites-enabled/*
rm -f /etc/apache2/sites-available/*

cp apache-default      /etc/apache2/sites-available/default.conf
cp apache-default-ssl  /etc/apache2/sites-available/default-ssl.conf

a2ensite default
a2ensite default-ssl

a2enmod headers
a2enmod rewrite
a2enmod ssl

cp ssl-snakeoil.crt /etc/ssl/certs/ssl-cert-snakeoil.pem
cp ssl-snakeoil.key /etc/ssl/private/ssl-cert-snakeoil.key

/etc/init.d/apache2 reload