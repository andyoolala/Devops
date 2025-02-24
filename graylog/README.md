# Graylog on Container + Ubuntu + HTTPs


## install Ubuntu 22.04

## Repository 

```
$ vi /etc/apt/source.lst
deb http://tw.archive.ubuntu.com/ubuntu/ jammy main restricted
deb http://tw.archive.ubuntu.com/ubuntu/ jammy-updates main restricted
deb http://tw.archive.ubuntu.com/ubuntu/ jammy universe
deb-src http://tw.archive.ubuntu.com/ubuntu/ jammy universe
deb http://tw.archive.ubuntu.com/ubuntu/ jammy-updates universe

```
![tt](./337003.jpg)

## Setup Graylog using docker

### Setup dedicated filesystem for graylog

```
$ fdisk /dev/sdb
Disk /dev/sdb: 200 GiB, 214748364800 bytes, 419430400 sectors
Disk model: Virtual disk
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xbe45419c

Device     Boot Start       End   Sectors  Size Id Type
/dev/sdb1        2048 419430399 419428352  200G 8e Linux LVM

$ pvcreate /dev/sdb1

$ vgcreate vg_graylog /dev/sdb1
$ mkdir /graylog
$ lvcreate -L 199G -n graylog vg_graylog
  Logical volume "graylog" created.
$ mkfs.ext4 /dev/mapper/vg_graylog-graylog
$ vi /etc/fstab 
/dev/mapper/vg_graylog-graylog /graylog          ext4    defaults       0       0
$ mount -a
$ chmod -R 777 /graylog
```

### Install Docker
```
$ cd ~/software
$ ls *.deb
Agent-Core-Ubuntu_22.04-20.0.0-7719.x86_64.deb
containerd.io_1.6.22-1_amd64.deb
docker-buildx-plugin_0.11.2-1~ubuntu.22.04~jammy_amd64.deb
docker-ce_24.0.6-1~ubuntu.22.04~jammy_amd64.deb
docker-ce-cli_24.0.6-1~ubuntu.22.04~jammy_amd64.deb
docker-ce-rootless-extras_24.0.6-1~ubuntu.22.04~jammy_amd64.deb
docker-compose-plugin_2.21.0-1~ubuntu.22.04~jammy_amd64.deb
$ sudo dpkg -i *.deb
```
### Setup Graylog Server to HTTPS
1. Create Self-Certificate CA
```
$ cd /graylog
$ mkdir ssl;cd ssl
$ vi ssl.conf
$ openssl req -new -nodes -sha256 -utf8 -newkey rsa:2048 -keyout server.key -out server.csr -config ssl.conf

```
3. Get CA from AD CS

4. Config nginx reverse proxy & HTTPS

- put ca files to nginx's dir
```
$ cp server.key /etc/nginx/ssl/
$ cp certnew.cer /etc/nginx/ssl/server.csr
```
> file **certnew.cer** is download from ca server

- edit config
```
$  vi /graylog/nginx/conf.d/graylog.conf
```

### Launch Graylog Server
```bash
$ sudo docker load -i graylog-5-1-2.tar
$ sudo docker load -i mongo-6-0-9.tar
$ sudo docker load -i elasticsearch-7-17-2.tar
$ sudo docker load -i nginx.tar
$ cd /graylog/
$ vi docker-compose.yml
$ chmod -R 755 /graylog
```

### Start Graylog

```
$ sudo docker compose  up -d

```

