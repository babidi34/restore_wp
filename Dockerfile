FROM debian:10

RUN apt-get update && apt-get install -y default-mysql-server apache2 openssl php-gd php-intl php-mbstring php-imagick
COPY wp.sql /tmp/wp.sql
COPY setup_db.sh /tmp/setup_db.sh
RUN chmod +x /tmp/setup_db.sh
RUN ["/tmp/setup_db.sh"]