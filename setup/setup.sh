APP="MobiOs"
SERVER_DIR="mobios"
ANDROID_CLIENT="android_client"
CURRENT_DIR=$(pwd)


echo "[*] Setting up Mobios enviroments"

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install curl
sudo apt-get install wget
curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh
./nodesource_setup.sh
sudo apt-get update
sudo apt-get install nodejs
source ~/.bashrc
npm install -g node-gyp
sudo apt-get install git
sudo apt get install pm2

sudo apt-get install build-essential
sudo apt-get install python
sudo apt install -y mongodb
sudo systemctl enable mongodb

cd /tmp
wget https://www.multichain.com/download/multichain-1.0.5.tar.gz
tar -xvzf multichain-1.0.5.tar.gz
cd multichain-1.0.5
mv multichaind multichain-cli multichain-util /usr/local/bin
cd $HOME
mkdir $APP
cd MobiOs
mkdir server
mkdir $ANDROID_CLIENT
cd server && git clone https://DragonsAndPostModernists@bitbucket.org/DragonsAndPostModernists/urbanconnect.git $SERVER_DIR
cd $SERVER_DIR
cp $CURRENT_DIR/.env .
npm install

echo "[*] Setup done would you like to start the server? Y/n"
read choice
if [ "$choice" == "y"  ] || [ "$choice" == "Y"  ] then
  # this command will change to pm2 later
  node keystone.js
else
  echo "[*] Goodbye ."
  exit
