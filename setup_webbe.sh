#!/bin/bash
#1. Deploy Linux VM, vmwebbe
#2. copy PEM file to WSL /home/tony/.ssh
#3. Adding inbound port for vmwebbe 3001
#4. sudo vi /etc/mongod.conf --> BindIP에 사설 IP 추가, "127.0.0.1,192.168.4.4"

#Install NodeJS
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt-get update
apt-get install -y nodejs build-essential

#GitHub Source Cloning
git clone https://github.com/microsoft/MCW-Cloud-native-applications.git /home/tony/GitSources

#Copy Source
cp -r /home/tony/GitSources/Hands-on\ lab/lab-files/infrastructure/content-api/ /home/tony/

#API 서버(content-api) 설정 및 확인
#fileName=/home/tony/content-api/config/config.js
#echo "exports.appSettings = {db: (function(){ return process.env.MONGODB_CONNECTION || 'mongodb://20.194.59.239:27017/contentdb';})()};">${fileName}

#Change DB IP
cd /home/tony/content-api
sudo sed -i 's/localhost/192.168.4.4/g' ./config/config.js

npm install
nodejs server.js &