#!/bin/bash
set -x

sudo apt-get -y install build-essential wget curl git-core jq
sudo bash -c 'echo LC_ALL="en_US.UTF-8" >> /etc/default/locale'
wget -q -O - https://get.docker.io/gpg | sudo apt-key add -
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get -y update
sudo apt-get -y upgrade
# Install Jenkins
sudo useradd jenkins 
echo Hello, begin the script
sudo apt-get install -y default-jdk
sudo apt-get update -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c "echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list"
sudo apt-get update -y
sudo apt-get install -y jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
sudo useradd -u jenkins -g jenkins -m -d /var/lib/jenkins -s /bin/bash jenkins
# Install Docker
sudo apt-get -y install docker.io
sudo adduser vagrant docker
sudo adduser vagrant jenkins
sudo adduser jenkins docker
sudo usermod -aG docker jenkins
sudo service docker restart
# Install jenkins plugins
cat <<EOL | sudo -u jenkins xargs -P 5 -n 1 wget -nv -T 60 -t 3 -P /var/lib/jenkins/plugins
https://updates.jenkins-ci.org/download/plugins/ansicolor/0.5.2/ansicolor.hpi
https://updates.jenkins-ci.org/download/plugins/ssh/2.6.1/ssh.hpi
https://updates.jenkins-ci.org/download/plugins/ssh-agent/1.17/ssh-agent.hpi
https://updates.jenkins-ci.org/download/plugins/sonar/2.8.1/sonar.hpi
https://updates.jenkins-ci.org/download/plugins/nexus-jenkins-plugin/3.3.20181102-112614.a65c3f1/nexus-jenkins-plugin.hpi

EOL
# Restart jenkins service
sudo service jenkins restart
echo Jenkins is installed. Use the below pwd to unlock...
sudo touch /opt/pass.txt
sudo cat /var/lib/jenkins/secrets/initialAdminPassword >> /opt/pass.txt
echo Access Jenkins server using below address..
hostname -I | cut -f2 -d' '