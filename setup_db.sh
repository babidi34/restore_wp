#!/bin/bash

SERVER_IP=$(ip route get 1 | awk '{print $7}')

# Démarrage de MySQL
service mysql start

# Attente que MySQL soit prêt
while ! mysqladmin ping -hlocalhost --silent; do
    sleep 1
done

# Création de la base de données et des utilisateurs
mysql -e "CREATE DATABASE IF NOT EXISTS wordpress_db; \
          GRANT ALL ON wordpress_db.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password'; \
          FLUSH PRIVILEGES;"

# Mise à jour des options de WordPress
mysql wordpress_db < /opt/$db_wp
mysql wordpress_db -e "UPDATE wp_options SET option_value='https://$SERVER_IP/' WHERE option_name='siteurl' OR option_name='home';" || mysql wordpress_db -e "UPDATE mod440_options SET option_value='https://$SERVER_IP/' WHERE option_name='siteurl' OR option_name='home';"
