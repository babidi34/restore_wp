docker rm -f debian-wp wp
docker image rm debian-wp

source .env

if [[ "$1" == "update_db" ]]; then
  python3 dl_last_db.py
fi

if [[ "$1" == "update_source" ]]; then
  bash dl_src.sh
fi

if [[ "$1" == "full_update" ]]; then
  bash dl_src.sh
  python3 dl_last_db.py
fi

archive_wp=$(ls -1 wp_*.tar | sort -r | head -n 1)
db_wp=$(ls -1 wp_*.sql | sort -r | head -n 1)
docker build  -t debian-wp --build-arg archive_wp=$archive_wp --build-arg db_wp=$db_wp --build-arg domain_name=$domain_name .

docker run -tid --name wp -p 443:443 debian-wp
