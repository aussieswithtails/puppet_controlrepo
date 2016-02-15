class bootstrap::common {
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

  file {['/etc/facter', '/etc/facter/facter.d']:
    ensure  => directory,
  }

  file {'/etc/facter/facter.d/environment.yaml':
    ensure  => file,
    content => file('bootstrap/environment.yaml'),
    mode    => '0644',
  }
}