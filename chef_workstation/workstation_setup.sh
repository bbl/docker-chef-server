#!/usr/bin/env bash

: "${CHEF_USER:?Need to set \$CHEF_USER non-empty}"
: "${CHEF_ORG:?Need to set \$CHEF_ORG non-empty}"
: "${CHEF_SERVER:?Need to set \$CHEF_SERVER non-empty}"

cd /chef_repo

knife ssl fetch
knife client list
knife cookbook upload chef_repo