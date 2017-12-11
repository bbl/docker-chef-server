#!/usr/bin/env bash

docker rm -f chef-test-node

docker run -dti --privileged -h chef-test-node --name chef-test-node ubuntu /sbin/init

docker cp install_chef_client.sh chef-test-node:/tmp/

docker exec -t chef-test-node chmod +x /tmp/install_chef_client.sh

docker exec -t chef-test-node /tmp/install_chef_client.sh
