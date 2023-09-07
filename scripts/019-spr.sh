#!/bin/sh

SPR_HOME=/home/spr
mkdir $SPR_HOME 2>/dev/null
cd $SPR_HOME

git clone https://github.com/spr-networks/super.git
cd super
#cp docker-compose-virt.yml docker-compose.yml
docker-compose -f docker-compose-virt.yml pull # update latest
#./pull_containers.sh
