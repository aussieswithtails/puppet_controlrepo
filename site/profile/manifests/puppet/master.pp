# Class: profile::puppet::master
#
# This class defines the profile required
# to be an awt puppetdb host
#
# Sample Usage:
#
#   include ::profile::puppet::master

class profile::puppet::master {
  include ::puppetdb::master::config
}

