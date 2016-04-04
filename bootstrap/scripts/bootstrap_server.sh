#!/usr/bin/env bash
source /vagrant/bootstrap/scripts/init_repo.sh
apt-get install -y puppetserver
/opt/puppetlabs/bin/puppet cert generate dserver.test #FixMe
source /vagrant/bootstrap/scripts/bootstrap_r10k.sh

# If there is no certificate for our host, generate one
if ! /opt/puppetlabs/bin/puppet cert list -a |grep -q "^+ \"$1\""
then
	echo "No cert found for pserver.test. Generating..."
    /opt/puppetlabs/bin/puppet cert generate dserver.test
else
	echo "Cert for pserver.test already exists"
fi
