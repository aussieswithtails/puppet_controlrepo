# Class: profile::vagrant_server
#
# This class installs, configures and sets up a system to host a Vagrant
# server
#
# Sample Usage:
#
#   include profile::vagrant_server


class profile::vagrant_server(
  $btrfs_device = hiera('btrfs_device'),
) {
  $btrfs_admin_mountpoint = hiera('awt::btrfs::admin_mountpoint')
  $btrfs_vagrantrepo_subvolume_id = '@vagrant'
  $btrfs_vagrantrepo_subvolume_path = "${btrfs_admin_mountpoint}/${btrfs_vagrantrepo_subvolume_id}"
  $vagrantrepo_mountpoint = '/srv/vagrant'
  $vagrantrepo_owner = 'www-data'
  $vagrantrepo_group = 'www-data'

  ensure_resource('user', $vagrantrepo_owner, {
    "ensure"     => present,
    "home"       => '/var/www/html',
    "managehome" => true,
    "shell"      => '/usr/sbin/nologin',
    "system"     => true,
  })

  ensure_resource('profile::types::file_and_mount', $btrfs_admin_mountpoint, {
    file_params  => { },
    mount_params => {
      'atboot' => false,
      'ensure' => mounted,
      'device' => $btrfs_device,
      'fstype' => 'btrfs',
    },
  })

  subvolume { $btrfs_vagrantrepo_subvolume_path: #FixMe - I don't like syntax here. Should be a parameter that specifies
    ensure  => present,              # path to where btrfs is mounted
    require => Profile::Types::File_and_mount[$btrfs_admin_mountpoint]
  }

  profile::types::file_and_mount { $vagrantrepo_mountpoint:
    file_params  => {
      'owner' => $vagrantrepo_owner,
      'group' => $vagrantrepo_group,
    },
    mount_params => {
      'ensure'  => mounted,
      'atboot'  => true,
      'device'  => $btrfs_device,
      'fstype'  => btrfs,
      'options' => "defaults,subvol=${btrfs_vagrantrepo_subvolume_id}",
    },
    require      => [User[$vagrantrepo_owner], Subvolume[$btrfs_vagrantrepo_subvolume_path]],
  }

  include nginx

}