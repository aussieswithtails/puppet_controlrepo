# Class: profile::base::users_and_groups
#
# This class installs, configures and sets awt users
# and groups that should exist on all nodes
#
# Sample Usage:
#
#   include profile::base::users_and_groups

class profile::base::users_and_groups {
  include ::profile::base::params

  user { $profile::base::params::admin_user:
    ensure         => present,
    comment        => 'Standard Administrative User',
    expiry         => absent,
    groups         => [$profile::base::params::admin_group,],
    home           => "/home/${profile::base::params::admin_user}",
    managehome     => true,
    purge_ssh_keys => true,
    shell          => '/bin/zsh',
    require        => Package['zsh'],
  }

  group { $profile::base::params::admin_group:
    ensure => present,
    system => true,
    before => User[$profile::base::params::admin_user],
  }
}