## site.pp ##
# Disable filebucket by default for all File resources:
#http://docs.puppetlabs.com/pe/latest/release_notes.html#filebucket-resource-no-longer-created-by-default
#File { backup => false }


notify{'Configure an AWT Test PuppetServer':}
file {'autosign.conf':
  ensure  => file,
  path    => "${settings::confdir}/autosign.conf",
  content => file('bootstrap/autosign.conf'),
  mode    => '0644',
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

service {'puppetserver':
  ensure  => running,
}

# FixMe duplicated in configure server
file { 'environment_link':
  ensure => link,
  path   => "${settings::codedir}/environments/development",
  target => '/vagrant',
}

host { 'pagent':
  ensure       => present,
  name         => 'pagent.test',
  host_aliases => ['pagent',],
  ip           => '192.168.99.101',
}
