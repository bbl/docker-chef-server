FROM phusion/baseimage

RUN apt-get update && apt-get install -y \
                cron
                curl
                iputils-ping
                nano
                net-tools
                tzdata
                wget

RUN wget -O /tmp/chef-server.deb \
        https://packages.chef.io/files/stable/chef-server/12.17.5/ubuntu/16.04/chef-server-core_12.17.5-1_amd64.deb && \
        dpkg -i /tmp/chef-server.deb

COPY chef_server_reconfigure.sh /etc/my_init.d/
