#!/bin/bash

# Database credentials
db_user="wordpress_user"
db_password="password"
db_name="wordpress_db"
db_host="localhost"


# Path to wp-config.php
wp_config="/var/www/wp-config.php"

# Update database credentials in wp-config.php
sed -i "s/define('DB_NAME', '.*');/define('DB_NAME', '$db_name');/" $wp_config
sed -i "s/define('DB_USER', '.*');/define('DB_USER', '$db_user');/" $wp_config
sed -i "s/define('DB_PASSWORD', '.*');/define('DB_PASSWORD', '$db_password');/" $wp_config
sed -i "s/define('DB_HOST', '.*');/define('DB_HOST', '$db_host');/" $wp_config
