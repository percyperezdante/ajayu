#!/bin/bash

set -x

yum remove ruby -y
yum purge ruby

############################
# Installing ruby
echo "roy"
echo $PATH
# --> Dependencies
yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison sqlite-devel

# --> Install RVM
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
curl -L get.rvm.io | bash -s stable
echo "PERCY"
echo $PATH

source /etc/profile.d/rvm.sh


#/usr/local/rvm/bin/rvm reload
#/usr/local/rvm/bin/rvm requirements run
rvm reload
rvm requirements run

# --> Install ruby 2.5
rvm install ruby-2.5.7
rvm use 2.5.7 --default

ruby -v

############################
# Installing capistrano 2.5
ls -ltr /usr/local/rvm/rubies/ruby-2.5.7/bin/
gem install capistrano -v 2.15.9
cap -V

# This is to avoid the follwoing error
# /usr/bin/env: ruby_executable_hooks: No such file or directory
# Cap points to ...wrappers/cap instaed of ...bin/cap

ln -s /usr/local/rvm/gems/ruby-2.5.7/wrappers/cap /usr/bin/cap


#############################
# Adjust deploy user settings
sudo useradd -m -b /home deploy
sudo echo "deploy:123" | chpasswd
cp -r /tmp/jenkins/sshDeploy /home/deploy/.ssh
chmod 700 /home/deploy/.ssh
chown -R deploy: /home/deploy/.ssh


#############################
# Reference
# https://tecadmin.net/install-ruby-latest-stable-centos/





