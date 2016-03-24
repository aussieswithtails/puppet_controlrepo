# Implements Base profile
class profile::base {
  notify { 'profile::base':
    message => 'Module ::profile::base',
  }

  $admin_user = 'administrator'
  $admin_group = 'admin'
  #
  #the base profile should include component modules that will be on all nodes
  include ::ntp

  package {'zsh':
    ensure => present,
    before => User[$admin_user],
  }

  group { 'admin':
    ensure  => present,
    system  => true,
    before  => User[$admin_user],
  }

  user { $admin_user:
    ensure         => present,
    comment        => 'Standard Administrative User',
    expiry         => absent,
    groups         => [$admin_group,],
    home           => "/home/${admin_user}",
    managehome     => true,
    purge_ssh_keys => true,
    shell          => '/bin/zsh',
  }

  ssh_authorized_key { 'snesbitt':
    ensure => present,
    user   => $admin_user,
    type   => hiera('awt::ssh::key_type'),
    # key    => hiera('awt::user::snesbitt.ssh_key_content'),
    key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA0fSQTmZM1YiWAYIVfS5vgrGwst9SGQMcDMheKlrar2wW7Y262JDQWgf8FCZjn4t4FG2L6z4VFNKLRg2UIwmh2uT3p9+sul0oyWrVeukYUrslZl5wrZxpuy1OgVJSeoATmB0JTzIIPu+eQDsCDNthUH+cGTBDKkhquRvmBo/jZ4CPEpqANh6wWpQJQUPIzoCiS+mBtl+0dI2BReFr/SVH9ebZ3vmc+vBZppqz7EqHdeL8psgqGkFA+YNYN0qDKSdU4mWgOkvsTDCWGkeAq4Yn8Kir0mntYE4lFcSFOflLJLgX9k3m9RVy2O4tsCujtX6fKWC/zi+J96Dtso56Xgoi/Q==',
  }

  include sudo
  include sudo::configs

  sudo::conf { $admin_group:
    content   => "%${admin_group} ALL=(ALL) NOPASSWD: ALL",
    priority  => 10,
  }
}
