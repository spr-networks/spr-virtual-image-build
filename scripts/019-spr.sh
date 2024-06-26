#!/bin/sh
set -x
install_deps() {
        # install upstream docker
        apt-get -y install ca-certificates curl gnupg
        install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
        chmod a+r /etc/apt/keyrings/docker.gpg

        echo \
                "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
                tee /etc/apt/sources.list.d/docker.list > /dev/null

        apt update
        apt-get -y install --no-install-recommends docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

apt-get update
apt-get upgrade
install_deps

SPR_HOME=/home/spr
mkdir $SPR_HOME 2>/dev/null
cd $SPR_HOME

git clone https://github.com/spr-networks/super.git
cd super
#cp docker-compose-virt.yml docker-compose.yml
docker compose -f docker-compose-virt.yml pull # update latest
#./pull_containers.sh

dd if=/dev/zero of=/swapfile bs=1024 count=256k
chown root:root /swapfile
chmod 0600 /swapfile
mkswap /swapfile
#sudo swapon /swapfile

echo "/swapfile       none    swap    sw      0       0" >>/etc/fstab

echo vm.swappiness = 10 | tee -a /etc/sysctl.conf

# disable systemd-resolved
systemctl disable systemd-resolved
rm -f /etc/resolv.conf
echo nameserver 1.1.1.1 > /etc/resolv.conf

# no snap
sudo systemctl stop snapd
sudo apt remove --purge --assume-yes snapd gnome-software-plugin-snap
