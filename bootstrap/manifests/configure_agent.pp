## site.pp ##
# Disable filebucket by default for all File resources:
#http://docs.puppetlabs.com/pe/latest/release_notes.html#filebucket-resource-no-longer-created-by-default
#File { backup => false }
class bootstrap::configure_agent {

  notify{ 'Configuring an AWT Test Puppet Agent': }
  include bootstrap::common

  file { '/etc/udev/rules/10-network.rules':
    ensure  => present,
    content => 'SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="08:00:27:5c:10:ac", NAME="eth1"'
  }

  # FixMe duplicated in configure server
  file { 'environment_link':
    ensure => link,
    path   => "${settings::codedir}/environments/development",
    target => '/vagrant',
  }

  host { 'pserver':
    ensure       => present,
    name         => 'pserver.test',
    ip           => '192.168.99.101',
    host_aliases => 'pserver',
  }
}
