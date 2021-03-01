#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo yum install git -y
git clone https://github.com/jitsi/docker-jitsi-meet
cd docker-jitsi-meet

wget ${env_file_url}
cp my_environment .env


./gen-passwords.sh
mkdir -p ~/.jitsi-meet-cfg/{web/letsencrypt,transcripts,prosody/config,prosody/prosody-plugins-custom,jicofo,jvb,jigasi,jibri}

## Sista stegen är att köra
#docker-compose up -d
## vilket aktiverar allting.
## Men det är problem med usermod -a -G docker ec2-user osv, 
## så måste se till att det löser sig.
