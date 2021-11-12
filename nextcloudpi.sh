#!bin/bash

# Install Prerequisties
echo Installing Prerequisties..
echo Installing Docker...
sudo apt install docker

echo Installing IProute2 and creating local variables...
sudo apt -y install iproute2

# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
# Create Public IP variable and bind to show default Public IP
mypublicip=$(curl https://ipinfo.io/ip)


# remove old docker image if present
sudo docker rm -f nextcloudpi
# Pulls docker image
sudo docker pull nextcloud
# Runs Installs Docker image
# sudo docker run -d -p 4443:4443 -p 8443:443 -p 8092:80 -v /home/james/plex/plexmedia/nextcloud:/data --name nextcloudpi nextcloud $DOMAIN

 docker run -d \
    -v /media/james/pi-ssd/container-program-files/nextcloud/nextcloudroot:/var/www/html \
    -v /media/james/pi-ssd/container-program-files/nextcloud/apps:/var/www/html/custom_apps \
    -v /media/james/pi-ssd/container-program-files/nextcloud/config:/var/www/html/config \
    -v /media/james/pi-ssd/container-program-files/nextcloud/data:/var/www/html/data \
    -v /media/james/pi-ssd/nextcloud_files:/data \
    -p 8443:443 \
    -p 8092:80 \
    --name nextcloudpi \
    nextcloud \

#Set Nextcloud docker instance to restart automatic on system reboot
sudo docker update --restart unless-stopped nextcloudpi


echo
echo
echo ----------------- Jenkins URLS---------------------------
echo
echo Local Addresses: "$mylocalip:8092" 
echo Public Address:  "$mypublicip:8092"
echo
echo -------------------------------------------------------------------
echo
echo
echo Finished!
