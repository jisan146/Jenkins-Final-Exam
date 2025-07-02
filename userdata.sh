#!/bin/bash

yum update -y

yum install -y java-1.8.0-openjdk-devel

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
yum install -y jenkins

yum install -y docker

systemctl start docker
systemctl enable docker

usermod -aG docker jenkins

systemctl start jenkins
systemctl enable jenkins

systemctl restart jenkins
systemctl restart docker

systemctl enable jenkins
systemctl enable docker
