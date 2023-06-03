#!/bin/bash
source .env
# Définition des variables

remote_path="/home/${username}/www/"
local_path="./www/"
DATE=$(date +%Y-%m-%d-%H-%M-%S)
archive_name="wp_${DATE}.tar"

# Connexion SFTP et téléchargement du contenu du dossier www/
sshpass -p $sftp_pass sftp -o StrictHostKeyChecking=no -P $port $username@$host << EOF
  get -r $remote_path $local_path
  quit
EOF

# Création de l'archive
tar -czvf $archive_name $local_path

# Suppression du dossier local
rm -r $local_path 