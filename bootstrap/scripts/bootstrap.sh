#!/usr/bin/env bash
# ToDo - Parameterize 1) path to puppet, 2) verbosity and debug, 3) path to bootstrap directory
apt-get update && apt-get install -y puppetserver
apt-get update
/opt/puppetlabs/bin/puppet module install zack/r10k
/opt/puppetlabs/bin/puppet apply /vagrant/bootstrap/manifests/r10k.pp
r10k deploy environment --verbose
