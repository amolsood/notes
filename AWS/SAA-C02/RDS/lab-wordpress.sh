sudo apt-get update -y
sudo apt-get upgrade -y

# Apache installation
sudo apt-get install apache2 apache2-utils -y
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl status apache2
sudo ufw allow in "Apache"
sudo ufw status
# check apache

## (Optional)
# PHP Installation (Optional)
sudo apt-get install php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y
sudo systemctl restart apache2
sudo vi /var/www/html/info.php
# <?php
# phpinfo();
# ?>
# Test at http://server/info.php
## (Optional)

wget -c http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
sudo mv wordpress/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
sudo rm -rf index.html

cd /var/www/html/
sudo mv wp-config-sample.php wp-config.php
sudo vim wp-config.php

sudo systemctl restart apache2.service

# http://server/wp-admin/install.php