FROM phusion/baseimage

RUN apt-get update && apt-get install -y \
                cron
                curl
                iputils-ping
                nano
                net-tools
                tzdata
                wget

RUN wget -O /tmp/chef-client.deb \
        https://packages.chef.io/files/stable/chef/13.6.4/ubuntu/16.04/chef_13.6.4-1_amd64.deb && \
        dpkg -i /tmp/chef-client.deb
