# Class: profile::base::packages
#
# This class installs, configures and sets up packages
# that should be available on all systems
#
# Sample Usage:
#
#   include profile::base::packages

class profile::base::packages {
  include ::profile::base::params

  package { 'htop':
    ensure  => present,
  }

  include ::ntp

  include ::sudo
  include ::sudo::configs
  sudo::conf { $profile::base::params::admin_group:
    content  => "%${profile::base::params::admin_group} ALL=(ALL) NOPASSWD: ALL",
    priority => 10,
  }

  package { 'zsh':
    ensure => present,
    before => User[$profile::base::params::admin_user],
  }
}

