# Implenets Base profile
class profile::base {
  notify { 'profile::base':
    message => 'Module ::profile::base',
  }
  #the base profile should include component modules that will be on all nodes
  include ::ntp
}
