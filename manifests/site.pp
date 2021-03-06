## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
#http://docs.puppetlabs.com/pe/latest/release_notes.html#filebucket-resource-no-longer-created-by-default
#File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  #incude a role on any node that specifies it's role via a trusted fact at provision time
  #https://docs.puppetlabs.com/puppet/latest/reference/lang_facts_and_builtin_vars.html#trusted-facts
  #https://docs.puppetlabs.com/puppet/latest/reference/ssl_attributes_extensions.html#aws-attributes-and-extensions-population-example

#  if !empty( $trusted['extensions']['pp_role'] ) {
#    include "role::${trusted['extensions']['pp_role']}"
#  }

  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  include ::profile::base
}

node 'dserver.test' {
  include ::role::puppet_test_server
}

node 'loki.samdom.aussieswithtails.fuzzbutt' {
  include ::role::development_workstation
}

# node 'puppetmaster01.samdom.aussieswithtails.fuzzbutt', 'oberon.samdom.aussieswithtails.fuzzbutt' {
#   ini_setting { 'server':
#     ensure  => present,
#     section => 'master',
#     setting => 'server',
#     value   => $facts['fqdn'],
#     path    => "${::settings::confdir}/puppet.conf",
#   }
#
#   ini_setting { 'certname':
#     ensure  => present,
#     section => 'master',
#     setting => 'certname',
#     value   => $facts['fqdn'],
#     path    => "${::settings::confdir}/puppet.conf",
#   }
#
#   ini_setting { 'agent_server':
#     ensure  => present,
#     section => 'agent',
#     setting => 'server',
#     value   => $facts['fqdn'],
#     path    => "${::settings::confdir}/puppet.conf",
#   }
#
#  include ::role::fuzzbuttnet_master_server
# #  include role::puppetmaster_copy
# #  include role::example
# }

node 'zwaveserver01.samdom.aussieswithtails.fuzzbutt' {
  include ::role::zwave_server
}

