#!bin/bash

# system host prereqs
sudo apt-get install libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip  
sudo pip3 install docker-compose

# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show ens33 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)


# Pull/Run container
sudo docker pull portainer/portainer-ce
# remove old images
sudo docker rm -f portainer

# Launch Portainer

sudo docker volume create portainer_data

docker run -d -p 8000:8000 -p 8090:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

sudo docker update --restart unless-stopped portainer

echo
echo
echo ----------------- Portainer URLS---------------------------
echo
echo Local Address: "$mylocalip:8090"
echo
echo run Run the following command to deploy the Agent in your Docker host:
echo docker run -d -p 9091:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent
echo -------------------------------------------------------------------
echo
echo
echo Finished!
