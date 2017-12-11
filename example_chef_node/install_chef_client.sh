#!/usr/bin/env bash

apt-get update

sysctl -w kernel.shmmax=1288490189

mkdir -p /tmp/chef_install

cd /tmp/chef_install

apt-get install -y wget

apt-get install -y tzdata

apt-get -y install cron

apt-get install -y --allow-unauthenticated net-tools

apt-get install -y iputils-ping

apt-get install -y nano


wget https://packages.chef.io/files/stable/chef/13.1.31/ubuntu/16.04/chef_13.1.31-1_amd64.deb

dpkg -i chef_*.deb

# Do some chef pre-work
/bin/mkdir -p /etc/chef
/bin/mkdir -p /var/lib/chef
/bin/mkdir -p /var/log/chef

echo '172.17.0.3	chef-server' >> /etc/hosts

#cd /etc/chef/

#cat > "/etc/chef/first-boot.json" << EOF
#{
#   "run_list" :[
#   "role[base]"
#   ]
#}
#EOF

# ssl_verify_mode        :verify_none