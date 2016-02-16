class profile::puppet::server {
  file {'hiera.yaml':
    ensure  => file,
    path    => "${settings::codedir}/hiera.yaml",
    content => file('site/profile/hiera.yaml'),
    mode    => '0644',
  }
  include ::puppetdb
  include ::puppetdb::master::config
}