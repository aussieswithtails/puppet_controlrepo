

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


  notify { 'Applying profile: profile::git::gitolite': }
  notify { "Debug: btrfs_admin_mountpoint = ${btrfs_admin_mountpoint}":}
  notify { "Debug: btrfs_device = ${btrfs_device}":}
  notify { "Debug: btrfs_gitolite_subvolume_id = ${btrfs_gitolite_subvolume_id}":}
  notify { "Debug: gitolite_server_id = ${gitolite_server_id}":}
  notify { "Debug: gitolite_mountpoint  = ${gitolite_mountpoint}":}
  notify { "Debug: gitolite_server_owner = ${gitolite_server_owner}":}
  notify { "Debug: gitolite_server_group = ${gitolite_server_group}":}
  notify { "Debug: btrfs_subvolume_path = ${btrfs_subvolume_path}":}

  include ::gitolite

  user { $gitolite_server_owner:
    ensure     => present,
    home       => $gitolite_mountpoint,
    managehome => true,
    shell      => hiera('awt::nologin_shell'),
    system     => true,
  }


  profile::types::file_and_mount { $btrfs_admin_mountpoint:
    file_params  => { },
    mount_params => {
      'atboot' => false,
      'ensure' => mounted,
      'device' => $btrfs_device,
      'fstype' => 'btrfs',
    },
  }

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
