#!bin/bash

# system host prereqs
sudo apt-get install libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip  
sudo pip3 install docker-compose

# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)


# Pull/Run container
docker pull pagracia/rpi-sonarqube
# remove old images
sudo docker rm -f sonarqube

# Launch Sonar qube
docker run -d --name sonarqube -p 8096:9000 pagracia/rpi-sonarqube:7.9.5-lts

sudo docker update --restart unless-stopped sonarqubed

echo
echo
echo ----------------- SonarQube URLS---------------------------
echo
echo Local Address: "$mylocalip:8096"
echo Default Login: admin/admin
echo
echo -------------------------------------------------------------------
echo
echo
echo Finished!
