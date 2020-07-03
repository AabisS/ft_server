service mysql start

# Config Access
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Generate website folder
mkdir /var/www/42project && touch /var/www/42project/index.php
echo "<?php phpinfo(); ?>" >> /var/www/42project/index.php

# SSL
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/42project.pem -keyout /etc/nginx/ssl/42project.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=fmarckma/CN=42project"

# Config NGINX
mv ./config_file/nginx-conf /etc/nginx/sites-available/42project
ln -s /etc/nginx/sites-available/42project /etc/nginx/sites-enabled/42project
rm -rf /etc/nginx/sites-enabled/default

# Config MYSQL
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# DL phpmyadmin
mkdir /var/www/42project/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/42project/phpmyadmin
mv ./config_file/phpmyadmin.inc.php /var/www/42project/phpmyadmin/config.inc.php

# DL wordpress
cd /config_file/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/42project
mv /config_file/wp-config.php /var/www/42project/wordpress

service php7.3-fpm start
service nginx start
bash
