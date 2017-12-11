#!/usr/bin/env bash
#
# This scripts setups chef-server. User and organization created if needed.
# `chef-server-ctl reconfigure` runs every time during container startup.

: "${CHEF_USER:?Need to set \$CHEF_USER non-empty}"
: "${CHEF_EMAIL:?Need to set \$CHEF_EMAIL non-empty}"
: "${CHEF_PSWD:?Need to set \$CHEF_PSWD non-empty}"
: "${CHEF_ORG:?Need to set \$CHEF_ORG non-empty}"

###########
# Arguments:
#   $1 - message
function info(){
    local YELLOW='\033[1;33m'
    local NC='\033[0m' # No Color
    echo -e "${YELLOW}${1}${NC}"
}

###########
# Arguments:
#   $1 - private key path
#   $2 - public key path
function generate_key_pair(){
    openssl genpkey -algorithm RSA -out "${1}" -pkeyopt rsa_keygen_bits:2048
    openssl rsa -pubout -in "${1}" -out "${2}"
}

sysctl -w kernel.shmmax=1288490189
sysctl net.ipv6.conf.lo.disable_ipv6=0

/opt/opscode/embedded/bin/runsvdir-start &

info 'Running reconfigure..'
chef-server-ctl reconfigure

chef-server-ctl user-show "${CHEF_USER}" || {
    info 'No chef server user found, generating new one..'
    chef-server-ctl user-create "${CHEF_USER}" "${CHEF_USER}" "${CHEF_USER}" "${CHEF_EMAIL}" "${CHEF_PSWD}" -f /dev/null
    if [[ ! -f /etc/chef/keys/client/client.pub ]]; then
       mkdir -p /etc/chef/client
       generate_key_pair /etc/chef/keys/client/client.pem /etc/chef/keys/client/client.pub
    fi

    chef-server-ctl delete-user-key "${CHEF_USER}" default
    chef-server-ctl add-user-key "${CHEF_USER}" --key-name default --pub-key-path /etc/chef/keys/client/client.pub
}

chef-server-ctl delete-user-key "${CHEF_USER}" default
chef-server-ctl add-user-key "${CHEF_USER}" --key-name default --pub-key-path /etc/chef/keys/client/client.pub

chef-server-ctl org-show "${CHEF_ORG}" || {
    info 'No chef server org found, generating new one..'
    chef-server-ctl org-create "${CHEF_ORG}" "${CHEF_ORG} inc" -a "${CHEF_USER}" -f /dev/null
    if [[ ! -f /etc/chef/org/validator.pub ]]; then
        mkdir -p /etc/chef/org
        generate_key_pair /etc/chef/keys/org/validator.pem /etc/chef/keys/org/validator.pub
    fi
}

chef-server-ctl delete-client-key "${CHEF_ORG}" "${CHEF_ORG}-validator" default
chef-server-ctl add-client-key "${CHEF_ORG}" "${CHEF_ORG}-validator" --key-name default --pub-key-path /etc/chef/keys/org/validator.pub