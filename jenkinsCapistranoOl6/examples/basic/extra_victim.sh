#!/bin/bash
set -x
sudo useradd -m -b /home deploy
sudo echo "deploy:123" | chpasswd
cp -r /vagrant/sshVictim /home/deploy/.ssh
chmod 700 /home/deploy/.ssh
chown -R deploy: /home/deploy/.ssh


