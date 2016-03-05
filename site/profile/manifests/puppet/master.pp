class profile::puppet::master {
  $hiera_yaml = "${::settings::confdir}/hiera.yaml"

  class { 'hiera':
    hierarchy  => [
      'nodes/%{::trusted.certname}',
      'tier/%{facts.tier}',
      'global',
    ],
    hiera_yaml => $hiera_yaml,
    datadir    => '/etc/puppetlabs/code/environments/%{environment}/hieradata',
    owner      => 'puppet',
    group      => 'puppet',
    notify     => Service['puppetserver'],
  }


  contain ::puppetdb
  contain ::puppetdb::master::config
}