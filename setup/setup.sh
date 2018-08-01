#!/bin/sh

MOBIOS_USER="urbanconnect"
APP="MobiOs"
SERVER_DIR="mobios"
MOBIOS_USER="urbanconnect"
ANDROID_CLIENT="android_client"
CURRENT_DIR=$(pwd)


echo "[*] Setting up new Mobios enviroments "
sleep 2

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install curl
sudo apt-get -y install wget
sudo apt-get -y install git

git config --global user.email "example@mobios.com"
git config --global user.name "mobios"
git config --global core.autocrlf false

sudo apt-get -y install libssl-dev
sudo apt-get -y install build-essential
sudo apt-get -y install python


echo "[*] Installing NVM and nodejs 8 "
sleep 2

nodeV=$(node -v)


curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
sudo apt-get update

export NVM_DIR="$(pwd)/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nvm install 8
nvm use 8
echo "[*] Installing node-gyp "
sleep 2
sudo npm install -g node-gyp

echo "[*] Installing extra dependencies "
sleep 2

sudo apt-get -y install libkrb5-dev
sudo apt get -yinstall pm2
sudo apt install -y mongodb
echo "[*] enabling MongoDB on boot "
sudo apt-get install -y tmux
sleep 2
sudo systemctl enable mongodb

echo "[*] Downloading and installing multichain"
sleep 2
cd /tmp
wget https://www.multichain.com/download/multichain-1.0.5.tar.gz
tar -xvzf multichain-1.0.5.tar.gz
cd multichain-1.0.5
sudo mv multichaind multichain-cli multichain-util /usr/local/bin
echo "[*] multichain installed getting mobios sources"
sleep 2

cd $HOME
mkdir $APP
cd $APP
mkdir $ANDROID_CLIENT
git clone https://DragonsAndPostModernists@bitbucket.org/DragonsAndPostModernists/urbanconnect.git $SERVER_DIR
cd $SERVER_DIR
touch .env

echo "COOKIE_SECRET=sdkaxarttflknkdtehhndpikqydcntyssfxgszlzxcnfhilbtphudcicmoxlkcnqmkjdlkvgbjdkflhkqixdqzljvphnnlszfmpkpykuhxpcymmelhprsnpukybfmpzy" >.env
echo "MOBIOS_EMAIL_SERVICE=gmail" >> .env
echo "MOBIOS_EMAIL_PASSWORD=0862427997" >> .env
echo "MOBIOS_EMAIL_ADDRESS=mobiosdonotreply@gmail.com" >> .env

npm install

echo "[*] Setup done would you like to start the server? Y/n"
read choice
if [ "$choice" == "y"  ] || [ "$choice" == "Y"  ] then
     node keystone.js
else
  echo "[*] Goodbye ."
  exit
fi
