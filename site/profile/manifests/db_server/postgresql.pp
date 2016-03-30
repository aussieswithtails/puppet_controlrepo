# Class: profile::db_server::postgresql
#
# This class installs, configures and sets an AWT
# compliant postgresql db server instance
#
# Sample Usage:
#
#   include profile::db_server::postgresql
class profile::db_server::postgresql {
  #ToDo: Add in btrfs subvolume creation
  include ::postgresql::server

  postgresql::server::pg_hba_rule { 'postgresql_global_access':
    address     => ".${::hiera('awt:network:domain_name')}",
    auth_method => 'md5',
    database    => 'all',
    type        => 'host',
    user        => 'all',
  }
}

