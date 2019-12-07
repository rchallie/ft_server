apt-get update
apt-get upgrade -y
apt-get -y install nginx
apt-get -y install default-mysql-server

# Config NGINX
mkdir /var/www/monsupersite && touch /var/www/monsupersite/index.html
cp /root/nginx-conf /etc/nginx/sites-available/monsupersite
ln -s /etc/nginx/sites-available/monsupersite /etc/nginx/sites-enabled/monsupersite
rm -rf /etc/nginx/sites-enabled/default

service nginx reload
service mysql start
/usr/sbin/nginx -g "daemon off;"
