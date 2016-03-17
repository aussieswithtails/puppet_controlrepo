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
  $btrfs_host_volume = hiera('btrfs_device')  #ToDo - Currently lack of value causes failure of catalog.
                                              #Instead lack of value should result in failure of this profile only!
  $btrfs_admin_mountpoint = '/mnt/btrfs'
  $btrfs_vms_subvolume = '@vms'
  $vms_mountpoint = '/var/lib/vms'
  $btrfs_subvolume_path = "${btrfs_admin_mountpoint}/${btrfs_vms_subvolume}"

  include ::vagrant
  include ::virtualbox

  # Create a vms subvolume
  mkdir::p { 'btrfs_admin_mount_point':
    path    => $btrfs_admin_mountpoint,
    before  => Mount[$btrfs_admin_mountpoint],
  }

  mount { $btrfs_admin_mountpoint:
    ensure => mounted,
    device => $btrfs_host_volume,
    fstype => 'btrfs',
    before  => Subvolume[$btrfs_subvolume_path]
  }

  subvolume { $btrfs_subvolume_path: #FixMe - I don't like syntax here. Should be a parameter that specifies
    ensure  => present,              # path to where btrfs is mounted
  }

  # Create the vms mount point and mount the btrfs vms subvolume
  mkdir::p { 'vms_repo':
    path    => $vms_mountpoint,
    before  => Mount[$vms_mountpoint]
  }

}