
FROM debian:buster

RUN apt-get update && apt-get install -y procps && apt-get install nano && apt-get install -y wget
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN apt-get -y install wget
RUN apt-get -y install mariadb-server
RUN apt-get -y install nginx
RUN mkdir ./config_file

COPY ./srcs/phpmyadmin.inc.php ./config_file/phpmyadmin.inc.php
COPY ./srcs/nginx-conf ./config_file/nginx-conf
COPY ./srcs/wp-config.php ./config_file/wp-config.php
COPY ./srcs/init_container.sh ./

CMD bash init.sh
