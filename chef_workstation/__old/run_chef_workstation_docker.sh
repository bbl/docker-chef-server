#!/usr/bin/env bash


docker rm -f chef-workstation

docker run -dti --privileged -h chef-workstation --name chef-workstation ubuntu /sbin/init

docker cp install_chef_workstation.sh chef-workstation:/tmp/

docker exec -t chef-workstation chmod +x /tmp/install_chef_workstation.sh

docker exec -t chef-workstation /tmp/install_chef_workstation.sh

