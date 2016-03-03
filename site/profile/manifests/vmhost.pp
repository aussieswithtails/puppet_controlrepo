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

#  $filtered_data = filter($::partitions.keys) |$partition| {
#    $partition[$partition] =~ /ext4/
#}

    notice( "Btrfs Partitions: #{$::btrfs_partitions}")
#  $::partitions.each |Array $partition| {
#      notice($partition[0])
#    }

  # create btrfs subvolumes as necessary
  # mount subvolume
  # add vagrant file
}