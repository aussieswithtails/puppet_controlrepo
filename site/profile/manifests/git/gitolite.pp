class profile::git::gitolite (
  $btrfs_device = hiera('btrfs_device'), #ToDo - Currently lack of value causes failure of catalog. Instead lack of value should result in failure of this profile only!
){
  $gitolite_server_id = 'gitolite'
  $btrfs_admin_mountpoint = hiera('awt::btrfs::admin_mountpoint')
  $btrfs_gitolite_subvolume_id = '@gitolite'
  $btrfs_subvolume_path = "${btrfs_admin_mountpoint}/${btrfs_gitolite_subvolume_id}"
  $gitolite_server_owner = 'gitolite'
  $gitolite_server_group = 'gitolite'
  $gitolite_mountpoint = "${hiera('awt::server_home')}/${gitolite_server_id}"

  include ::gitolite

  user { $gitolite_server_owner:
    ensure     => present,
    home       => $gitolite_mountpoint,
    managehome => true,
    shell      => '/bin/bash',
    system     => true,
  }

  ssh_keygen { $gitolite_server_owner:
    bits    => hiera('awt::ssh::key_size'),
    home    => $gitolite_mountpoint,
    type    => hiera('awt::ssh::key_type'),
    require => Profile::Types::File_and_mount[$gitolite_mountpoint],
  }

  ensure_resource('profile::types::file_and_mount', $btrfs_admin_mountpoint, {
    file_params  => { },
    mount_params => {
      'atboot' => false,
      'ensure' => mounted,
      'device' => $btrfs_device,
      'fstype' => 'btrfs',
    },
  })


  subvolume { $btrfs_subvolume_path: #FixMe - I don't like syntax here. Should be a parameter that specifies
    ensure  => present,              # path to where btrfs is mounted
    require => Profile::Types::File_and_mount[$btrfs_admin_mountpoint],
  }


  profile::types::file_and_mount { $gitolite_mountpoint:
    file_params  => {
      'owner' => $gitolite_server_owner,
      'group' => $gitolite_server_group,
    },
    mount_params => {
      'ensure'  => mounted,
      'atboot'  => true,
      'device'  => $btrfs_device,
      'fstype'  => btrfs,
      'options' => "defaults,subvol=${btrfs_gitolite_subvolume_id}",
    },
    require      => [User[$gitolite_server_owner], Subvolume[$btrfs_subvolume_path]],
  }
}
