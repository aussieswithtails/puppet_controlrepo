#!/usr/bin/env bash
# ToDo - Parameterize 1) path to puppet, 2) verbosity and debug, 3) path to bootstrap directory
source /vagrant/bootstrap/scripts/init_repo.sh
apt-get install -y puppetserver
/opt/puppetlabs/bin/puppet cert generate pserver.test #FixMe
source /vagrant/bootstrap/scripts/bootstrap_r10k.sh

# If there is no certificate for our host, generate one
if ! /opt/puppetlabs/bin/puppet cert list -a |grep -q "^+ \"$1\""
then
	echo "No cert found for $1. Generating..."
    /opt/puppetlabs/bin/puppet cert generate $1
else
	echo "Cert for $1 already exists"
fi
