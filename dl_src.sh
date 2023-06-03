#!/bin/bash
source .env
# Définition des variables

remote_path="/home/${username}/www/"
local_path="./www/"
DATE=$(date +%Y-%m-%d-%H-%M-%S)
archive_name="wp_${DATE}.tar"

sshpass -p $sftp_pass sftp -o StrictHostKeyChecking=no -P $port $username@$host << EOF
  get -r $remote_path $local_path
  quit
EOF

tar -czvf $archive_name $local_path

rm -r $local_path

# keep 2 lasts backups, remove the others
ls -1tr wp_*.tar | sort | head -n -2 | xargs -d '\n' rm -f --