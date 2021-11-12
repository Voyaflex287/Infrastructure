#!bin/bash

# system host prereqs
sudo apt-get install libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip  
sudo pip3 install docker-compose

# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)


# Pull/Run container
sudo docker pull nicolargo/glances
# remove old images
sudo docker rm -f glances-sys-monitor

# Launch Portainer
sudo docker run --name glances-sys-monitor -d --restart="always" -p 8093:61208 -e GLANCES_OPT="-w" -v /var/run/docker.sock:/var/run/docker.sock:ro --pid host nicolargo/glances


sudo docker update --restart unless-stopped glances-sys-monitor

echo
echo
echo ----------------- Glances URLS---------------------------
echo
echo Local Address: "$mylocalip:8093"
echo
echo
echo -------------------------------------------------------------------
echo
echo
echo Finished!
