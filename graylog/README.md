sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

https://download.docker.com/linux/ubuntu/dists/jammy/pool/stable/amd64/


vagrant@vagrant:~/dpkg$ ls
containerd.io_1.6.22-1_amd64.deb                            
docker-ce_24.0.6-1~ubuntu.22.04~jammy_amd64.deb      
docker-ce-rootless-extras_24.0.6-1~ubuntu.22.04~jammy_amd64.deb
docker-buildx-plugin_0.11.2-1~ubuntu.22.04~jammy_amd64.deb  
docker-ce-cli_24.0.6-1~ubuntu.22.04~jammy_amd64.deb  
docker-compose-plugin_2.21.0-1~ubuntu.22.04~jammy_amd64.deb

sudo dpkg -i *.deb


sudo docker pull mongo:6.0.9

sudo docker pull mongo:4.4.6

sudo docker pull elasticsearch:7.17.2

sudo docker pull graylog/graylog:5.1.2

sudo docker pull graylog/graylog:4.0.15