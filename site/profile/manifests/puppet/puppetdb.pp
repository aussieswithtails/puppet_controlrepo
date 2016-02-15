class profile::puppet::puppetdb {
  include ::puppetdb
  include ::puppetdb::master::config
}