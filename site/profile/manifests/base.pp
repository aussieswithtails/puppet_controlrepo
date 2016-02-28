# Implements Base profile
class profile::base {
  notify { 'profile::base':
    message => 'Module ::profile::base',
  }
  #
  #the base profile should include component modules that will be on all nodes
  include ::ntp

  package {'zsh':
    ensure => present,
    before => User['administrator'],
  }

  group { 'admin':
    ensure  => present,
    system  => true,
    before  => User['administrator'],
  }

  user {'administrator':
    ensure         => present,
    comment        => 'Standard Administrative User',
    expiry         => absent,
    groups         => ['admin'],
    home           => '/home/administrator', #FixMe - is there a way to reference the name of this resource?
    managehome     => true,
    purge_ssh_keys => true,
    shell          => '/bin/zsh',
  }

  ssh_authorized_key { 'snesbitt':
    ensure => present,
    user   => 'administrator',
    type   => 'rsa',
    key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA0fSQTmZM1YiWAYIVfS5vgrGwst9SGQMcDMheKlrar2wW7Y262JDQWgf8FCZjn4t4FG2L6z4VFNKLRg2UIwmh2uT3p9+sul0oyWrVeukYUrslZl5wrZxpuy1OgVJSeoATmB0JTzIIPu+eQDsCDNthUH+cGTBDKkhquRvmBo/jZ4CPEpqANh6wWpQJQUPIzoCiS+mBtl+0dI2BReFr/SVH9ebZ3vmc+vBZppqz7EqHdeL8psgqGkFA+YNYN0qDKSdU4mWgOkvsTDCWGkeAq4Yn8Kir0mntYE4lFcSFOflLJLgX9k3m9RVy2O4tsCujtX6fKWC/zi+J96Dtso56Xgoi/Q==',
  }

  include sudo
  include sudo::configs
}
