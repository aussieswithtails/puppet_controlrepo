# Class: profile::puppet::puppetdb_server
#
# This class defines the profile required
# to be an awt puppetdb host
#
# Sample Usage:
#
#   include ::profile::puppet::puppetdb_server

class profile::puppet::puppetdb_server {
  include ::profile::db_server::postgresql
  include ::puppetdb
  include ::puppetdb::master::config
}