docker rm -f debian-wp wp
docker image rm debian-wp

archive_wp=$(ls -1 wp_*.tar | sort -r | head -n 1)
db_wp=$(ls -1 wp_*.sql | sort -r | head -n 1)
docker build  -t debian-wp --build-arg archive_wp=$archive_wp --build-arg db_wp=$db_wp .

docker run -tid --name wp -p 443:443 debian-wp
