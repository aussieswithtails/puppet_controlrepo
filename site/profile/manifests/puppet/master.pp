class profile::puppet::master {
#  file {'hiera.yaml':
#    ensure  => file,
#    path    => "${settings::codedir}/hiera.yaml",
#    content => file('profile/hiera.yaml'),
#    mode    => '0644',
#  }
  include hiera

  include ::puppetdb
  include ::puppetdb::master::config
}
