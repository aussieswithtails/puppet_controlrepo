#!/usr/bin/env bash
cd /var/tmp
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
dpkg -i /var/tmp/puppetlabs-release-pc1-trusty.deb
apt-get update