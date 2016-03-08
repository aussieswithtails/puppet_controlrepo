#!/usr/bin/env bash

alias doagent='sudo /opt/puppetlabs/bin/puppet agent --environment=development --test'
alias doapply='sudo /opt/puppetlabs/bin/puppet apply --environment=development --test'
alias dor10k='sudo r10k deploy environment -pv'
alias showpserverlog='sudo less /var/log/puppetlabs/puppetserver/puppetserver.log'