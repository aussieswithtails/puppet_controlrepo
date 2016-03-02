# Class: profile::vmhost
#
# This class installs, configures and sets up a system which will host
# one or more virtual machines
#
# Sample Usage:
#
#   include ::profile::vmhost
#
class profile::vmhost {
  include vagrant
  include virtualbox

  # create btrfs subvolumes as necessary
  # mount subvolume
  # add vagrant file
}