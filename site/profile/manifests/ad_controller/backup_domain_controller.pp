# Class: profile::ad_controller::backup_domain_controller
#
# This class installs, configures and sets up a system which will host
# one or more virtual machines
#
# Sample Usage:
#
#   include ::profile::vmhost
#
class profile::ad_controller::backup_domain_controller {

  case $::osfamily {
    'Debian': {
      include profile::vmhost
    }
  }

  # create btrfs subvolumes as necessary
  # mount subvolume
  # add vagrant file
}