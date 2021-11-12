#!bin/bash

# Create local IP variable and bind to show default local interface IP
mylocalip=$(sudo ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
# Create Public IP variable and bind to show default Public IP
mypublicip=$(curl https://ipinfo.io/ip)

# Step 4: Set up the VPN container

sudo docker rm -f ovpn-server
sudo docker volume rm ovpn-data

OVPN_DATA="ovpn-data"

sudo docker volume create --name $OVPN_DATA
sudo docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm mjenz/rpi-openvpn ovpn_genconfig -u udp://$mypublicip
sudo docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it mjenz/rpi-openvpn ovpn_initpki
sudo docker run --name ovpn-server -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN --restart always mjenz/rpi-openvpn

# Start VPN Container and build certificate
sudo docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it mjenz/rpi-openvpn easyrsa build-client-full CLIENTNAME nopass
sudo docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm mjenz/rpi-openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn


sudo docker exec -it ovepn-server cat /etc/openvpn/pki/private/CLIENTNAME.key.XXXXPmAALe
