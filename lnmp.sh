#!/bin/bash
yum -y install gcc gcc-c++ zlib openssl pcre pcre-devel zlib-devel openssl-devel libxml2 libxml2-devel make cmake ncurses-devel libtool-ltdl-devel autoconf automake bison zlib-devel
mkdir -p /opt/src /opt/app /opt/src/mysql


# download
cd /opt/src
wget http://nginx.org/download/nginx-1.9.9.tar.gz
wget http://cn2.php.net/distributions/php-5.5.31.tar.gz
cd /opt/src/mysql
wget http://cdn.mysql.com//Downloads/MySQL-5.5/MySQL-5.5.47-1.linux2.6.x86_64.rpm-bundle.tar


# unzip
cd /opt/src
tar -zxvf nginx-1.9.9.tar.gz
tar -zxvf php-5.5.31.tar.gz
cd /opt/src/mysql
tar -xvf MySQL-5.5.47-1.linux2.6.x86_64.rpm-bundle.tar

#yum remove -y mysql-libs

# install nginx
cd /opt/src/nginx-1.9.9
./configure --prefix=/opt/app/nginx --with-pcre
make && make install
cd /opt/app/nginx/conf/
cp -f /opt/src/lnmp/nginx.conf /opt/app/nginx/conf/
cp -f /opt/src/lnmp/nginx /etc/init.d/
chmod +x /etc/init.d/nginx
chkconfig --add nginx
chkconfig  nginx on


#install php
cd /opt/src/php-5.5.31
./configure --prefix=/opt/app/php --enable-fpm --enable-mbstring
make && make install
cp /opt/src/php-5.5.31/php.ini-production /opt/app/php/lib/php.ini
cp /opt/src/lnmp/php-fpm.conf /opt/app/php/etc/
cp /opt/src/lnmp/php-fpm /etc/init.d/
chkconfig --add php-fpm
chkconfig  php-fpm on


#install mysql
cd /opt/src/mysql
rpm -ivh --nosignature MySQL-server-5.5.47-1.linux2.6.x86_64.rpm MySQL-client-5.5.47-1.linux2.6.x86_64.rpm MySQL-devel-5.5.47-1.linux2.6.x86_64.rpm
cp /opt/src/lnmp/mysql /etc/init.d/
chkconfig --add mysql
chkconfig  mysql on
