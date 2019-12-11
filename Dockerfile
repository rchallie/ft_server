FROM debian:buster

RUN apt-get update && apt-get install -y procps && apt-get install nano && apt-get install -y wget
#RUN apt-get update && apt-get install -y procps && apt-get install nano && ap$
#RUN apt-get update
#RUN apt-get -y upgrade
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install default-mysql-server

COPY ./srcs/nginx-conf /root/nginx-conf
COPY ./srcs/phpmyadmin.inc.php /root/phpmyadmin.inc.php
COPY ./srcs/init_container.sh ./
COPY ./srcs/wp-config.php ./tmp

CMD bash init_container.sh
