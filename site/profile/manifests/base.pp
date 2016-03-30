# Implements Base profile
class profile::base {
  notify { 'profile::base':
    message => 'Module ::profile::base',
  }

  include ::profile::base::apps
  include ::profile::base::configuration
  include ::profile::base::params
  include ::profile::base::users_and_groups





  ssh_authorized_key { 'snesbitt':
    ensure => present,
    user   => $profile::base::params::admin_user,
    type   => hiera('awt::ssh::key_type'),
    key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA0fSQTmZM1YiWAYIVfS5vgrGwst9SGQMcDMheKlrar2wW7Y262JDQWgf8FCZjn4t4FG2L6z4VFNKLRg2UIwmh2uT3p9+sul0oyWrVeukYUrslZl5wrZxpuy1OgVJSeoATmB0JTzIIPu+eQDsCDNthUH+cGTBDKkhquRvmBo/jZ4CPEpqANh6wWpQJQUPIzoCiS+mBtl+0dI2BReFr/SVH9ebZ3vmc+vBZppqz7EqHdeL8psgqGkFA+YNYN0qDKSdU4mWgOkvsTDCWGkeAq4Yn8Kir0mntYE4lFcSFOflLJLgX9k3m9RVy2O4tsCujtX6fKWC/zi+J96Dtso56Xgoi/Q==',
  }

  ssh_authorized_key { 'vagrant':
    ensure    => present,
    user      => $profile::base::params::admin_user,
    type      => 'rsa',
    key       => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCfhF2A8Dpt1YjJoLYQDgXAFOXB+Gde18u/QPPmvriaiUTiqykDW7gHdAZ6nmV1RbiimgVjg3Tnv73wntZxDaWFTGHSSPaQgLf/Xia2MJ/VDdt7JNptGjXY0ukr2QFfXU/P3y77JSXiRgbqdTIvJj5ZszlBCtzrisJxGb7BUXbkInqjDBc0fpgjm/4af3/s/N/6DAvccsKaba0Yx3ErsDDiPLUP/Mr/eGp4C5n1kIyG+BZQM7iw58H1rqjE1A2XOJ9YqwyD7KtW6ClUO6MHK4GuqTkMiGrr5Ido66USDqWupHvEEvMfM3BloeCGMhRtaT6POhxVPj1jQF7hWLV3sw6T'
  }


}
