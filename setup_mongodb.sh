#!/bin/bash
#1. Deploy Linux VM, vmmongodb
#2. copy PEM file to WSL /home/tony/.ssh
#3. Adding inbound port for mongodb 27017

#Install NodeJS
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt-get update
apt-get install -y nodejs build-essential

#GitHub Source Cloning
git clone https://github.com/microsoft/MCW-Cloud-native-applications.git /home/tony/GitSources

#Copy Source
cp -r /home/tony/GitSources/Hands-on\ lab/lab-files/infrastructure/content-init/ /home/tony/

#Install Mongo DB for Ubuntu 1804
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list

apt-get update

apt-get install -y mongodb-org

sudo sed -i 's/127.0.0.1/127.0.0.1,192.168.3.5/g' /etc/mongod.conf

sudo systemctl start mongod

#MongoDB에 샘플 데이터 넣기
cd /home/tony/content-init
npm install
nodejs server.js