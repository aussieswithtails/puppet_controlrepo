# Implements Base profile
class profile::base {
  notify { 'Module ::profile::base':
  }

  include ::profile::base::apps
  include ::profile::base::configuration
  include ::profile::base::params
  include ::profile::base::users_and_groups
}
