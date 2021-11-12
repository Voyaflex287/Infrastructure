#!bin/bash

# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

docker pull caddy

# remove old images
sudo docker rm -f caddy-webserver

echo "hello world" > index.html
docker run -d -p 8080:80 --name=caddy-webserver \
    -v /home/james/websites:/index.html \
    -v /home/james/caddy_data:/data \
    caddy

curl http://localhost/8080

#Set Jebkins docker instance to restart automatic on system reboot
sudo docker update --restart unless-stopped caddy-webserver

# Set website root to /index.html/<your site folder here>
sudo docker exec -it caddy-webserver vi /etc/caddy/Caddyfile

echo
echo
echo ----------------- Plex URLS---------------------------
echo
echo Local Address: "$mylocalip:8080" or "localhost:8080"
echo
echo -------------------------------------------------------------------
echo
echo
echo Finished!
