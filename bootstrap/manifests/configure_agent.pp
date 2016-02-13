## site.pp ##
# Disable filebucket by default for all File resources:
#http://docs.puppetlabs.com/pe/latest/release_notes.html#filebucket-resource-no-longer-created-by-default
#File { backup => false }


notify{'Configuring an AWT Test Puppet Agent':}

#file {'puppet.conf':
#  ensure  => file,
#  path    => "${settings::confdir}/puppet.conf",
#  content => file('bootstrap/puppet.conf'),
#  mode    => '0644',
#}
#
#file {'hiera.yaml':
#  ensure  => file,
#  path    => "${settings::codedir}/hiera.yaml",
#  content => file('bootstrap/hiera.yaml'),
#  mode    => '0644',
#}

# FixMe duplicated in configure server
file { 'environment_link':
  ensure => link,
  path   => "${settings::codedir}/environments/development",
  target => '/vagrant',
}

host { 'pserver':
  ensure       => present,
  name         => 'puppetserver01.test',
  ip           => '192.168.99.103',
  host_aliases => 'puppetserver01, pserver',
}

