#!bin/bash

# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)


docker rm -f wordpress

docker pull wordpress

docker run --name wordpress -v /media/pi/pi-ssd/container-program-files/wordpress_data:/var/www/html -p 8083:80 -d wordpress

sudo docker update --restart unless-stopped wordpress


echo
echo
echo ----------------- Wordpress URLS---------------------------
echo
echo Local Address: "$mylocalip:8083" or "localhost:8091"
echo
echo -------------------------------------------------------------------
echo
echo
echo Finished!
