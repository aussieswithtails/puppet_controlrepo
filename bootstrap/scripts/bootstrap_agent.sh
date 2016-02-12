#!/usr/bin/env bash
# ToDo - Parameterize 1) path to puppet, 2) verbosity and debug, 3) path to bootstrap directory
source /vagrant/bootstrap/scripts/init_repo.sh

apt-get install -y puppet-agent

#source /vagrant/bootstrap/scripts/bootstrap_r10k.sh

