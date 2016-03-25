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
  $vagrantrepo_owner = 'vagrant-server'
  $vagrantrepo_group = 'vagrant-server'
  $vagrantrepo_home = '/srv/vagrant'


  # Create the subvolume and mount it
  # Add the vagrant server owner and create it with it's home directory being the mountpoint. Creation needs
  #   to include generation of ssh keys
  # Update gitolite as follows:
  #   add vagrant-server key to gitolite keys
  #   generate a vagrant bare repo
  #   create a template vagrant server repo and link it to the bare repo
  # Note I need to rethink gitolite management...


  # Create subvolume
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

  # Mount the subvolume
  file { $vagrantrepo_mountpoint:
  }

  mount { $vagrantrepo_mountpoint:
      ensure  => mounted,
      atboot  => true,
      device  => $btrfs_device,
      fstype  => btrfs,
      options => "defaults,subvol=${btrfs_vagrantrepo_subvolume_id}",
      require      => [File[$vagrantrepo_mountpoint], Subvolume[$btrfs_vagrantrepo_subvolume_path]],
  }

  # Create vagrant-server owner account
  ensure_resource('user', $vagrantrepo_owner, {
    "ensure"     => present,
    "home"       => $vagrantrepo_home,
    "managehome" => true,
    "shell"      => '/usr/sbin/nologin',
    "system"     => true,
    require      => Mount[$vagrantrepo_mountpoint]
  })

  ssh_keygen {$vagrantrepo_owner:
    home  => $vagrantrepo_home,
    comment => 'vagrant server key',
    type    => 'rsa',
    bits    => '4096',
    require => User[$vagrantrep_owner]
  }

  # vcsrepo { '/tmp/vagrant':
  #   ensure    => latest,
  #   provider  => git,
  #   source    => 'gitolite@gitolite01:testing',
  #   user      => 'administrator',
  #   require   => Profile::Types::File_and_mount[$vagrantrepo_mountpoint]
  # }

  # include nginx

}