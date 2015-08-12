#!/usr/bin/env bash

# Configure MySQL Server:
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server-5.5 mysql-server/root_password_again password root"

# Configure phpMyAdmin:
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password root"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password root"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password root"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"

# Set the timezone:
echo "America/New_York" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

# Update packages:
apt-get -qq update

# Install required packages:
apt-get install -y \
	curl \
	git-core \
	build-essential \
	apache2 \
	mysql-server \
	mysql-client \
	php5 \
	php5-mcrypt \
	php5-memcache \
	php5-mysql \
	php5-sqlite \
	php-pear \
	libapache2-mod-auth-mysql \
	libapache2-mod-php5 \
	phpmyadmin \
	nodejs \
	npm

# Alias "nodejs" as "node":
sudo ln -s /usr/bin/nodejs /usr/bin/node

# Update NPM and install common NPM packages:
npm install -g npm
npm install -g bower grunt-cli gulp yo	

# Install Composer:
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Update PHP5 post_max_size and upload_max_filesize (Apache only):
sed -i -e 's/^\(post_max_size\) = .*$/\1 = 128M/g' /etc/php5/apache2/php.ini
sed -i -e 's/^\(upload_max_filesize\) = .*$/\1 = 128M/g' /etc/php5/apache2/php.ini

# Configure the default Apache virtual host:
echo -e '
<VirtualHost *:80>
\tServerName localhost
\tDocumentRoot "/vagrant/public"
\t<Directory "/vagrant/public">
\t\tAllowOverride All
\t\tRequire all granted
\t</Directory>
</VirtualHost>
' > /etc/apache2/sites-available/000-default.conf 

# Enable Apache modules:
a2enmod rewrite

# Restart Apache:
service apache2 restart
