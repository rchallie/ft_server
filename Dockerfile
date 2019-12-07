FROM debian:buster

RUN apt-get update && apt-get install -y procps && apt-get install nano && apt-get install -y wget
COPY ./srcs/nginx-conf /root/nginx-conf
COPY ./srcs/wordpress-5.3.tar.gz /root/wordpress-5.3.tar.gz
COPY ./srcs/init_container.sh ./

CMD bash init_container.sh
