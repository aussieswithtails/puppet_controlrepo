class bootstrap::common {
  $custom_factor_dir = '/etc/facter/facts.d'


  mkdir::p { 'facts.d':
    path    => $custom_factor_dir,
    before  => File['environment_fact'],
  }

  file {'puppet.conf':
    ensure  => file,
    path    => "${settings::confdir}/puppet.conf",
    content => file('bootstrap/puppet.conf'),
    mode    => '0644',
  }

  file {'hiera.yaml':
    ensure  => file,
    path    => "${settings::codedir}/hiera.yaml",
    content => file('bootstrap/hiera.yaml'),
    mode    => '0644',
  }


  file { 'environment_fact':
    ensure  => file,
    path    => "$custom_factor_dir/environment.yaml",
    content => file('bootstrap/environment.yaml'),
    mode    => '0644',
  }
}