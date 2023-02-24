FROM debian:10

RUN apt-get update && apt-get install -y default-mysql-server apache2 libapache2-mod-php openssl php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip php7.3-mysql vim
COPY wp.sql /opt/wp.sql
COPY setup_db.sh /opt/setup_db.sh
RUN bash /opt/setup_db.sh

COPY edit_wp_config.sh /opt/edit_wp_config.sh
COPY vhost.conf /etc/apache2/sites-enabled/000-default.conf
COPY wp.tar /opt/wp.tar
RUN a2enmod ssl
RUN a2enmod rewrite
RUN openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout /opt/hostname.key -out /opt/hostname.crt -subj "/C=FR/ST=France/L=Paris/O=entreprise/CN=fqdn"
RUN tar -xvf /opt/wp.tar -C /var/
RUN bash /opt/edit_wp_config.sh


CMD apache2ctl start && mysqld