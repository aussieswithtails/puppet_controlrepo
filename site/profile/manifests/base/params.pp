# Class: profile::base::params
#
# This class defines parameters unique to the
# base profile
#
# Sample Usage:
#
#   include profile::base::params

class profile::base::params {
  $admin_user = 'administrator'
  $admin_group = 'admin'
  $puppet_agent_service = 'puppet'
}
