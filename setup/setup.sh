#!/usr/bin/env

APP="MobiOs"
SERVER_DIR="mobios"
ANDROID_CLIENT="android_client"
CURRENT_DIR=$(pwd)


echo "[*] Setting up new Mobios enviroments "
sudo useradd -m -s $(which bash) -G sudo mobios
echo "[*] Adding mobios ot sudo"

sudo -u someuser bash << EOF

echo "[*] user $(whoami) create starting setup"

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install curl
sudo apt-get install wget
sudo apt-get install git
sudo apt-get install libssl-dev
sudo apt-get install build-essential
sudo apt-get install python


echo "[*] Installing NVN and nodejs 8 "
sleep 2
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
source ~/.bashrc
nvm install 8
nvm use 8
echo "[*] Installing node-gyp "
sleep 2
npm install -g node-gyp

echo "[*] Installing extar dependencies "
sleep 2
sudo apt-get install libkrb5-dev
sudo apt get install pm2
sudo apt install -y mongodb
echo "[*] enabling MongoDB on boot "
sudo apt-get install tmux
sleep 2
sudo systemctl enable mongodb

echo "[*] Downloading and installing multichain"
sleep 2
cd /tmp
wget https://www.multichain.com/download/multichain-1.0.5.tar.gz
tar -xvzf multichain-1.0.5.tar.gz
cd multichain-1.0.5
mv multichaind multichain-cli multichain-util /usr/local/bin
echo "[*] Setting up vim plugins"
echo "[*] Installing extar dependencies "
sleep 2
mkdir ~/.vim
cd ~/.vim
mkdir bundle
mkdir autoload

# **************** vim NERD TREE ! comment this sline out if you want the NERD tree for vim
cd $HOME
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim/bundle
git clone https://github.com/scooloose/nerdtree.git
touch $HOME/.vimrc
echo ":set autoindent"            > $HOME/.vimrc
echo ":cindent"                  >> $HOME/.vimrc
echo ":set number"               >> $HOME/.vimrc
echo "execute pathogen#infect()" >> $HOME/.vimrc

cd $HOME
mkdir $APP
cd MobiOs
mkdir server
mkdir $ANDROID_CLIENT
cd server && git clone https://DragonsAndPostModernists@bitbucket.org/DragonsAndPostModernists/urbanconnect.git $SERVER_DIR
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
  # this command will change to pm2 later
  node keystone.js
else
  echo "[*] Goodbye ."
  exit
fi
EOF
