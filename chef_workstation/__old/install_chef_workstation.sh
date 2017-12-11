#!/usr/bin/env bash

apt-get update

sysctl -w kernel.shmmax=1288490189

mkdir -p /tmp/chef_install

cd /tmp/chef_install

apt-get install -y wget

apt-get install -y tzdata

apt-get -y install cron

apt-get install -y net-tools

apt-get install -y iputils-ping

wget https://packages.chef.io/files/stable/chefdk/1.4.3/ubuntu/16.04/chefdk_1.4.3-1_amd64.deb

dpkg -i chefdk*.deb

chef verify

echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile

source ~/.bash_profile

mkdir -p ~/chef-repo/.chef

