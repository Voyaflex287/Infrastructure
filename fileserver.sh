#!bin/bash

sudo docker rm -f fileserver

docker pull filebrowser/filebrowser

sudo docker run -d \
    -v /home/lucas/share_files:/srv \
    -v /media/lucas/container-program-files/fileserver/database.db:/database.db \
    -v /media/lucas/container-program-files/fileserver/filebrowser.json:/filebrowser.json \
    --name fileserver \
    --user $(id -u):$(id -g) \
    -p 8094:80 \
    filebrowser/filebrowser

sudo docker update --restart unless-stopped fileserver
