# Class: profile::vagrant_server
#
# This class installs, configures and sets up a Vagrant repository
#
# Sample Usage:
#
#   include ::profile::vmhost
class profile::vagrant_server {
  $btrfs_admin_mountpoint = '/mnt/btrfs'
  $www_subvolume_id = '@www'
  $vagrant_subvolume_id = 'vagrant'
  $vagrant_repo_mountpoint = '/srv/vagrant'
  $btrfs_host_volume = hiera('btrfs_device')  #ToDo - Currently lack of value causes failure of catalog.
  $vagrant_box_dir = "${vagrant_repo_mountpoint}/devops/boxes"

#  $btrfs_www_subvolume_path = "${btrfs_admin_mountpoint}/${www_subvolume_id}"
#  $btrfs_vagrant_subvolume = "${btrfs_www_subvolume_path}/$vagrant_subvolume_id"
#www-data

  # FixMe - this entire process of creating and mounting a btrfs subvolume should be put in a module
  # Create a vms subvolume
  mkdir::p { 'btrfs_admin_mount_point':
    path    => $btrfs_admin_mountpoint,
  }

  mount { $btrfs_admin_mountpoint:
    ensure => mounted,
    device => $btrfs_host_volume,
    fstype => 'btrfs',
    require => Mkdir::P['btrfs_admin_mount_point'],
  }

  subvolume { "${btrfs_admin_mountpoint}/${www_subvolume_id}": #FixMe - I don't like syntax here. Should be a parameter that specifies
    ensure  => present,              # path to where btrfs is mounted
    require => Mount[$btrfs_admin_mountpoint]
  }

  subvolume { "${btrfs_admin_mountpoint}/${www_subvolume_id}/${vagrant_subvolume_id}": #FixMe - I don't like syntax here. Should be a parameter that specifies
    ensure   => present,              # path to where btrfs is mounted
    require  => Subvolume["${btrfs_admin_mountpoint}/${www_subvolume_id}"]
  }

    # Create the vms mount point and mount the btrfs vms subvolume
  mkdir::p { $vagrant_repo_mountpoint:
    path    => $vagrant_repo_mountpoint,
    before  => Mount[$vagrant_repo_mountpoint]
  }

  mount { $vagrant_repo_mountpoint:
    ensure  => mounted,
    device  => $btrfs_host_volume,
    fstype  => 'btrfs',
    options => "defaults,subvol=${www_subvolume_id}/${vagrant_subvolume_id}",
    pass    => 2,
    require => Subvolume["${btrfs_admin_mountpoint}/${www_subvolume_id}/${vagrant_subvolume_id}"],
  }

  # Create the vagrant repo structure
  mkdir::p {'vagrant_boxes':
    path    => $vagrant_box_dir,
    owner   => $repo_owner,
    require => Mount[$vagrant_repo_mountpoint]
  }
}