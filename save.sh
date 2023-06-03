#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M-%S)
db_name="wordpress_db"
db_user="wordpress_user"
db_password="password"
db_host="localhost"
dump_name="wp_db_${DATE}.sql"
src_path="/var/www/"
folder_dest="/var/backups"
archive_name="wp_${DATE}.tar"

mkdir -p /var/backups

# Exporter la base de données
mysqldump -u $db_user -p$db_password -h $db_host $db_name > $folder_dest/$dump_name

# Exporter les sources
tar -czvf $folder_dest/$archive_name $src_path