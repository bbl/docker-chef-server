#!/usr/bin/env bash


docker rm -f chef-server

docker run -dti --privileged -h chef-server --name chef-server ubuntu /sbin/init

docker cp install_chef_server.sh chef-server:/tmp/

docker exec -t chef-server chmod +x /tmp/install_chef_server.sh

docker exec -t chef-server mkdir -p /etc/chef/
docker cp client chef-server:/etc/chef/
docker cp org chef-server:/etc/chef/


docker exec -t chef-server /tmp/install_chef_server.sh

