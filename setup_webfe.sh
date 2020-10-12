#!/bin/bash
#1. Deploy Linux VM, vmwebfe, adding port 3000
#2. copy PEM file to WSL /home/tony/.ssh
#3. Deploy Storage Account, sthealthcarekdk
#4. sudo vi app.js, modify API Server URL

#Install NodeJS
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt-get update
apt-get install -y nodejs build-essential

#Install Angular
npm install -g @angular/cli

#GitHub Source Cloning
git clone https://github.com/microsoft/MCW-Cloud-native-applications.git /home/tony/GitSources

#Copy Source
cp -r /home/tony/GitSources/Hands-on\ lab/lab-files/infrastructure/content-web/ /home/tony/

#프론트 엔드 웹 서버(content-web) 설정 및 확인
npm install --prefix /home/tony/content-web
cd /home/tony/content-web
sudo sed -i 's/localhost/192.168.4.4/g' app.js
ng build
node app.js &