#!/usr/bin/env bash
cd /var/tmp
wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i /var/tmp/puppetlabs-release-trusty.deb
apt-get update