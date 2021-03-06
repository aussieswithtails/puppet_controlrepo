# Class: profile::puppet::puppetdb_server
#
# This class defines the profile required
# to be an awt puppetdb host
#
# Sample Usage:
#
#   include ::profile::puppet::puppetdb_server

class profile::puppet::puppetdb_server {
  include ::puppetdb::master::config
  include ::profile::db_server::postgresql
  include ::puppetdb::server

  postgresql::server::pg_hba_rule { 'puppetdb access':
    address     => "127.0.0.1/26",
    auth_method => 'md5',
    database    => 'puppetdb',
    type        => 'host',
    user        => 'puppetdb',
  }

  #ToDo - needs to be a mechanism  to ensure that any change to the puppetdb password is accompanied by a corresponding postgres change...
}