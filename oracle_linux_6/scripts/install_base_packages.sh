#!/bin/bash

yum update -y

yum localinstall -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm

yum install -y tmux w3m vim

# set up deploy user
useradd -m -s /bin/bash -U deploy
echo "deploy    ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/deploy
