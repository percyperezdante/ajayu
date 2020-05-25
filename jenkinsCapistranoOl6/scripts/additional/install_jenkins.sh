#!/bin/bash

# Installing Jenkis from package
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

yum install java-1.8.0-openjdk.x86_64 -y
yum install jenkins -y


# Enabling ports 8080
iptables -I INPUT 5 -i eth0 -p tcp --dport 8080 -m state --state NEW,ESTABLISHED -j ACCEPT
service iptables save
service iptables restart
service jenkins restart

# Setting initial configuration

mkdir /app
mkdir /app/jenkins
mkdir /app/jenkins/log

MY_JENKINS_HOME="/app/jenkins"
MY_JENKINS_LOG="/app/jenkins/log"
JENKINS_DEFAULT_VARIABLES="/etc/sysconfig/jenkins"
sed -i 's/^JENKINS_HOME=/#JENKINS_HOME=/g' $JENKINS_DEFAULT_VARIABLES
sed -i 's/^JENKINS_LOG=/#JENKINS_LOG=/g'  $JENKINS_DEFAULT_VARIABLES
echo "JENKINS_HOME=${MY_JENKINS_HOME}" >> $JENKINS_DEFAULT_VARIABLES
echo "JENKINS_LOG=${MY_JENKINS_LOG}" >> $JENKINS_DEFAULT_VARIABLES

# To avoid show the installation wizard at the beginning
echo "JAVA_ARGS=\$JAVA_ARGS\" -Djenkins.install.runSetupWizard=false\"" >> $JENKINS_DEFAULT_VARIABLES
cp /tmp/jenkins/init.groovy.d $MY_JENKINS_HOME/

cp -r /tmp/jenkins/plugins $MY_JENKINS_HOME/
cp -r /tmp/jenkins/users $MY_JENKINS_HOME/

chown -R jenkins: /app/jenkins

usermod --home /app/jenkins jenkins
usermod -s /bin/bash jenkins

#####################################
# Adjusting jenkins user to work with capistrano
service jenkins stop

sudo usermod -d /app/jenkins -s /bin/bash  jenkins
cp -r /tmp/jenkins/sshJenkins /app/jenkins/.ssh
chmod 700 /app/jenkins/.ssh
chmod 600 /app/jenkins/.ssh/id_rsa
chown -R jenkins: /app/jenkins/.ssh

service jenkins start


