# Implements Base profile
class profile::base {
  notify { 'profile::base':
    message => 'Module ::profile::base',
  }

  include ::profile::base::packages
  include ::profile::base::params
  include ::profile::base::users_and_groups





  ssh_authorized_key { 'snesbitt':
    ensure => present,
    user   => $profile::base::params::admin_user,
    type   => hiera('awt::ssh::key_type'),
    key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA0fSQTmZM1YiWAYIVfS5vgrGwst9SGQMcDMheKlrar2wW7Y262JDQWgf8FCZjn4t4FG2L6z4VFNKLRg2UIwmh2uT3p9+sul0oyWrVeukYUrslZl5wrZxpuy1OgVJSeoATmB0JTzIIPu+eQDsCDNthUH+cGTBDKkhquRvmBo/jZ4CPEpqANh6wWpQJQUPIzoCiS+mBtl+0dI2BReFr/SVH9ebZ3vmc+vBZppqz7EqHdeL8psgqGkFA+YNYN0qDKSdU4mWgOkvsTDCWGkeAq4Yn8Kir0mntYE4lFcSFOflLJLgX9k3m9RVy2O4tsCujtX6fKWC/zi+J96Dtso56Xgoi/Q==',
  }


}
