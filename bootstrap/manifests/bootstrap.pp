## site.pp ##
# Disable filebucket by default for all File resources:
#http://docs.puppetlabs.com/pe/latest/release_notes.html#filebucket-resource-no-longer-created-by-default
#File { backup => false }


notify{'Configure an AWT Test Puppet System':}
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

host { 'puppetmaster':
  ip           => '10.0.2.15',
  host_aliases => ['puppet', ],
}

service {'puppetserver':
  ensure  => running,
}


