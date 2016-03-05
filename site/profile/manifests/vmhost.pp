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
#  $btrfs_host_volume = hiera('btrfs_device')
#  $btrfs_admin_mountpoint = hiera('btrfs_admin_mountpoint')
#  $btrfs_vms_subvolume = '@vms'
#  $vms_mountpoint = hiera('vms_repo')
#  $btrfs_subvolume_path = "${btrfs_admin_mountpoint}/${btrfs_vms_subvolume}"
#
#  include ::vagrant
#  include ::virtualbox
#
#
#  mkdir::p { 'btrfs_admin_mount_point':
#    path    => $btrfs_admin_mountpoint,
#  }
#
#  mkdir::p { 'vms_repo':
#    path    => $vms_mountpoint,
#  }
#
#  ::subvolume { $btrfs_subvolume_path:
#    ensure  => present,
#    require => Mount[$btrfs_admin_mountpoint],
#  }
#
#  mount { $btrfs_admin_mountpoint:
#    ensure => mounted,
#    device => $btrfs_host_volume,
#    fstype => 'btrfs',
#  }
#
#  mount { $vms_mountpoint:
#    ensure  => mounted,
#    device  => $btrfs_host_volume,
#    fstype  => 'btrfs',
#    options => "defaults,subvol=${btrfs_vms_subvolume}",
#    pass    => 2,
#    require => Subvolume[$btrfs_subvolume_path],
#  }
}