
ufw limit ssh
ufw allow 51280/udp
ufw --force enable

SPR_HOME=/home/spr
mkdir $SPR_HOME 2>/dev/null
cd $SPR_HOME

git clone https://github.com/spr-networks/super.git
cd super
cp docker-compose-virt.yml docker-compose.yml
./pull_containers.sh
