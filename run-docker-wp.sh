docker rm -f debian-wp wp

docker build -t debian-wp .

docker run -tid --name wp -p 443:443 debian-wp
