#!bin/bash


# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

sudo docker pull phpmyadmin

docker run --name myphpadmin -d --link mariadb:db -p 8095:80 phpmyadmin

sudo docker update --restart unless-stopped myphpadmin

echo
echo
echo ----------------- Wordpress URLS---------------------------
echo
echo Local Address: "$mylocalip:8095" or "localhost:8095"
echo
echo -------------------------------------------------------------------
echo
echo
echo Finished!
