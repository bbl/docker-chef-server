FROM phusion/baseimage

RUN apt-get update && apt-get install -y \
                cron
                curl
                iputils-ping
                nano
                net-tools
                tzdata
                wget

RUN wget -O /tmp/chef-dk.deb \
        https://packages.chef.io/files/stable/chefdk/2.3.4/ubuntu/16.04/chefdk_2.3.4-1_amd64.deb && \
        dpkg -i /tmp/chef-dk.deb

COPY workstation_setup.sh /etc/my_init.d/
