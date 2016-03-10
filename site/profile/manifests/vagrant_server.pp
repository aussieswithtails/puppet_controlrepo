class profile::vagrant_server {
  # create a btrfs subvolume to host the vagrant repository and
  # mount it at /var/www/<vagrant>
  $www_subvolume = '@www'
  $vagrant_subvolume = 'vagrant'
  $vagrant_repo_mountpoint = '/var/lib/www/vagrant'
  $btrfs_host_volume = hiera('btrfs_device')  #ToDo - Currently lack of value causes failure of catalog.
  #Instead lack of value should result in failure of this profile only!
  $btrfs_admin_mountpoint = '/mnt/btrfs'
  $btrfs_www_subvolume = "${btrfs_admin_mountpoint}/${www_subvolume}"
  $btrfs_vagrant_subvolume = "${btrfs_www_subvolume}/$vagrant_subvolume"


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

  subvolume { "${btrfs_admin_mountpoint}/${www_subvolume}": #FixMe - I don't like syntax here. Should be a parameter that specifies
    ensure  => present,              # path to where btrfs is mounted
    require => Mount[$btrfs_admin_mountpoint]
  }

  subvolume { "${btrfs_admin_mountpoint}/${www_subvolume}/${vagrant_subvolume}": #FixMe - I don't like syntax here. Should be a parameter that specifies
    ensure   => present,              # path to where btrfs is mounted
    require  => Subvolume["${btrfs_admin_mountpoint}/${www_subvolume}"]
  }

    # Create the vms mount point and mount the btrfs vms subvolume
  mkdir::p { $vagrant_repo_mountpoint:
    path    => $vagrant_repo_mountpoint,
    before  => Mount[$vagrant_repo_mountpoint]
  }
#
  mount { $vagrant_repo_mountpoint:
    ensure  => mounted,
    device  => $btrfs_host_volume,
    fstype  => 'btrfs',
    options => "defaults,subvol=${www_subvolume}/${vagrant_subvolume}",
    pass    => 2,
    require => Subvolume["${btrfs_admin_mountpoint}/${www_subvolume}/${vagrant_subvolume}"],
  }
#   add an nginx server

}