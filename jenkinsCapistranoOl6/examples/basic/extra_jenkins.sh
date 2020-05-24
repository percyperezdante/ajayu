#!/bin/bash
set -x
service jenkins stop
sudo usermod -d /app/jenkins -s /bin/bash  jenkins
cp -r /vagrant/sshJenkins /app/jenkins/.ssh
chmod 700 /app/jenkins/.ssh
chmod 600 /app/jenkins/.ssh/id_rsa
chown -R jenkins: /app/jenkins/.ssh
sudo echo "172.10.11.4 victim" >> /etc/hosts
service jenkins start


