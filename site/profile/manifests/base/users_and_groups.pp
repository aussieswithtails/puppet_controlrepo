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
  include ::sudo
  include ::sudo::configs

  group { $profile::base::params::admin_group:
    ensure => present,
    system => true
  }

  user { $profile::base::params::admin_user:
    ensure         => present,
    comment        => 'Standard Administrative User',
    expiry         => absent,
    groups         => [$profile::base::params::admin_group,],
    home           => "/home/${profile::base::params::admin_user}",
    managehome     => true,
    purge_ssh_keys => true,
    shell          => '/bin/zsh',
    require        => [Package['zsh'], Group[$profile::base::params::admin_group]]
  }

  sudo::conf { $profile::base::params::admin_group:
    content  => "%${profile::base::params::admin_group} ALL=(ALL) NOPASSWD: ALL",
    priority => 10,
  }

  $users_with_admin_access = hiera('awt::authorized_keys::administrator')
  $registered_ssh_keys = lookup("awt::registered_ssh_keys")

  $valid_ssh_keys = $registered_ssh_keys.filter |$items| { member($users_with_admin_access, $items[0]) }
  create_resources(ssh_authorized_key, $valid_ssh_keys, {'user' => $profile::base::params::admin_user, 'ensure' => present})


}