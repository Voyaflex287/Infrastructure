#!bin/bash

docker rm -f my-apache-app

docker pull httpd

sudo docker run -dit --name my-apache-app -p 8081:80 -v /media/james/pi-ssd/share_files/Websites/branconet:/usr/local/apache2/htdocs/ httpd:2.4