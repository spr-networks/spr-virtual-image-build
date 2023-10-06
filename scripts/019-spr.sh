#!/bin/sh

SPR_HOME=/home/spr
mkdir $SPR_HOME 2>/dev/null
cd $SPR_HOME

git clone https://github.com/spr-networks/super.git
cd super
#cp docker-compose-virt.yml docker-compose.yml
docker-compose -f docker-compose-virt.yml pull # update latest
#./pull_containers.sh

dd if=/dev/zero of=/swapfile bs=1024 count=256k
mkswap /swapfile
#sudo swapon /swapfile
chown root:root /swapfile
chmod 0600 /swapfile

echo "/swapfile       none    swap    sw      0       0" >>/etc/fstab

echo vm.swappiness = 10 | tee -a /etc/sysctl.conf

# disable systemd-resolved
systemctl disable systemd-resolved
rm -f /etc/resolv.conf
echo nameserver 1.1.1.1 > /etc/resolv.conf

# no snap
sudo systemctl stop snapd
sudo apt remove --purge --assume-yes snapd gnome-software-plugin-snap
