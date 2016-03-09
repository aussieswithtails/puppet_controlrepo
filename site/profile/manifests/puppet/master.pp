class profile::puppet::master {

  include hiera

  include ::puppetdb
  include ::puppetdb::master::config
}

