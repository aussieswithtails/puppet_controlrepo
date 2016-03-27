# Class: profile::base::configuration
#
# This class manages the configuration standard
# standard to all awt nodes
#
# Sample Usage:
#
#   include profile::base::configuration

# ToDo: How can we wrap all the indivual puppet.conf edits into a single notification???
class profile::base::configuration {
  notify { 'profile::base::files':
  message => "Module ${name}",
}
  include ::profile::base::params

  # Add custom facts
  mkdir::p { 'facts.d':
    path    => $profile::base::params::custom_facts_dir,
  }

  file { 'environment_fact':
    ensure  => file,
    group   => 'root',
    owner   => 'root',
    path    => "${profile::base::params::custom_facts_dir}/environment.yaml",
    source  => "puppet:///modules/${module_name}/environment.yaml",
    mode    => '0644',
  }

  # Configure puppet.conf
  ini_setting {'puppet_certname':
    ensure    => present,
    section   => 'main',
    path      => '/etc/puppetlabs/puppet/puppet.conf',
    setting   => 'certname',
    value     => $::facts['fqdn'],
    notify    => Service[$profile::base::params::puppet_agent_service],
  }

  ini_setting {'puppet_server':
    ensure    => present,
    section   => 'master',
    path      => '/etc/puppetlabs/puppet/puppet.conf',
    setting   => 'server',
    value     => hiera('awt::puppet::server.fqdn'),
    notify    => Service[$profile::base::params::puppet_agent_service],
  }

  ini_setting {'hiera_config':
    ensure  => present,
    section => 'main',
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    setting => 'hiera_config',
    value   => '/etc/puppetlabs/code/hiera.yaml',
    notify  => Service[$profile::base::params::puppet_agent_service],
  }

  # Configure auth.conf
  case $::facts['tier'] {
    'development': {
      $ip_interface = "ipaddress_${hiera('awt::puppet::server.ip_interface')}"

      notice( "shit: ${::facts[$ip_interface]}")
      file { 'environment_link':
        ensure => link,
        path   => "${settings::codedir}/environments/development",
        target => '/vagrant',
      }
      file { 'autosign.conf':
        ensure  => file,
        path    => "${settings::confdir}/autosign.conf",
        content => '*',
        mode    => '0644',
      }
      # host { $::facts['hostname']:
      #   ensure       => present,
      #   host_aliases => [$::facts['fqdn'],],
      #   ip           => $::facts[$ip_interface],
      # }
      # host { 'puppet_server':
      #   ensure       => present,
      #   host_aliases => [hiera('awt::puppet::server.name'), hiera('awt::puppet::server.fqdn')],
      #   ip           => hiera('awt::puppet::server.ip'),
      # }
    }
    default: {}
  }


}