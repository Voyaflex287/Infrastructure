#!bin/bash

# system host prereqs
sudo apt-get install libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip
sudo pip3 install docker-compose

# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show ens33 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

# Run container
docker-compose up --detach

echo
echo
echo ----------------- Pihole URLS---------------------------
echo
echo Local Addresse: "$mylocalip:8091/admin"
echo
echo PiHole Admin Password:
sudo docker exec -it pihole sudo pihole -a -p
echo
echo -------------------------------------------------------------------
echo
echo
echo Finished!
