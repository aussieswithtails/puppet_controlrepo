# Class: profile::base::apps
#
# This class installs, configures and manages standard
# awt apps
#
# Sample Usage:
#
#   include profile::base::packages

class profile::base::apps {
  include ::profile::base::params

  package { 'htop':
    ensure  => present,
  }

  include ::ntp

  package { $profile::base::params::puppet_agent_service:
    ensure  => present,
  }

  service { $profile::base::params::puppet_agent_service:
    ensure  => running,
    name    => 'puppet',
    enable  => true,
    require => Package[$profile::base::params::puppet_agent_service]
  }

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

