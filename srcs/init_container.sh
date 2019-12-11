service mysql start

# Config Access
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Generate website folder
mkdir /var/www/monsupersite && touch /var/www/monsupersite/index.php
echo "<?php phpinfo(); ?>" >> /var/www/monsupersite/index.php

# SSL
#mkdir /etc/nginx/ssl
#cd /etc/nginx/ssl
#wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64
#mv mkcert-v1.1.2-linux-amd64 mkcert
#chmod +x mkcert
#./mkcert -install
#./mkcert monsupersite
#cd
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/monsupersite.pem -keyout /etc/nginx/ssl/monsupersite.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=rchallie/CN=monsupersite"

# Config NGINX
cp /root/nginx-conf /etc/nginx/sites-available/monsupersite
ln -s /etc/nginx/sites-available/monsupersite /etc/nginx/sites-enabled/monsupersite
rm -rf /etc/nginx/sites-enabled/default

# Config MYSQL
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "CREATE USER 'wp'@'localhost' IDENTIFIED BY 'wordpress'; " | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password

# DL phpmyadmin
mkdir /var/www/monsupersite/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components 1 -C /var/www/monsupersite/phpmyadmin
mv /root/phpmyadmin.inc.php /var/www/monsupersite/phpmyadmin/config.inc.php

# DL wordpress
cd /tmp/
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress/ /var/www/monsupersite
mv /tmp/wp-config.php /var/www/monsupersite/wordpress

service php7.3-fpm start
service nginx reload
/usr/sbin/nginx -g "daemon off;"
