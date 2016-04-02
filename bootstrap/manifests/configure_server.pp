## site.pp ##
# Disable filebucket by default for all File resources:
#http://docs.puppetlabs.com/pe/latest/release_notes.html#filebucket-resource-no-longer-created-by-default
#File { backup => false }

class bootstrap::configure_server {
  notify{ 'Configure an AWT Test PuppetServer': }
  include bootstrap::common

  file { 'autosign.conf':
    ensure  => file,
    path    => "${settings::confdir}/autosign.conf",
    content => file('bootstrap/autosign.conf'),
    mode    => '0644',
  }

  service { 'puppetserver':
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
    name         => 'dagent.test',
    host_aliases => ['dpagent',],
    ip           => '192.168.99.102',
  }
}