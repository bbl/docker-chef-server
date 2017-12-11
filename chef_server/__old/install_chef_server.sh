#!/usr/bin/env bash

apt-get update

#docker command: /sbin/init

sysctl -w kernel.shmmax=1288490189

mkdir -p /tmp/chef_install

cd /tmp/chef_install

apt-get install -y wget

apt-get install -y tzdata

apt-get -y install cron

apt-get install -y net-tools

apt-get install -y iputils-ping

wget https://packages.chef.io/files/stable/chef-server/12.15.7/ubuntu/16.04/chef-server-core_12.15.7-1_amd64.deb

dpkg -i chef-server*.deb


chef-server-ctl reconfigure

chef-server-ctl user-create admin admin admin admin@example.com examplepass -f /dev/null

chef-server-ctl delete-user-key admin default

chef-server-ctl add-user-key admin --key-name default --pub-key-path /etc/chef/client/client.pub


chef-server-ctl org-create gex 'GEX inc' -a admin -f /dev/null

chef-server-ctl delete-client-key gex gex-validator default

chef-server-ctl add-client-key gex gex-validator --key-name default --pub-key-path /etc/chef/org/validator.pub