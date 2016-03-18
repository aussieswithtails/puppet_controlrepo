#ToDo - Refactor
# DRY

class profile::git::gitolite {
  notify { "Applying profile: profile::git::gitolite": }

  include gitolite

  user { 'gitolite':
    ensure     => present,
    home       => '/srv/gitolite',
    managehome => true,
    name       => 'gitolite',
    shell      => '/usr/sbin/nologin',
    system     => true,

  }




  #  notify {"Debug - Prior to Config":
  #    before  => Class['Gitolite::Config']
  #  }
  $btrfs_host_volume = hiera('btrfs_device')  #ToDo - Currently lack of value causes failure of catalog.
  #Instead lack of value should result in failure of this profile only!
  $btrfs_admin_mountpoint = hiera('profile::btrfs::admin_mountpoint')
  $btrfs_gitserver_subvolume = '@gitolite'
  $gitolite_mountpoint = hiera('gitolite::home_dir')
  $btrfs_subvolume_path = "${btrfs_admin_mountpoint}/${btrfs_gitserver_subvolume}"

  profile::types::file_and_mount { '/mnt/btrfs':
    file_params   => { },
    mount_params  => {
      'atboot'  => false,
      'ensure'  => mounted,
      'device'  => $btrfs_host_volume,
      'fstype'  => 'btrfs',
    },
  }

  subvolume { $btrfs_subvolume_path: #FixMe - I don't like syntax here. Should be a parameter that specifies
    ensure   => present,              # path to where btrfs is mounted
    require  => Profile::Types::File_and_mount['/mnt/btrfs']
  }


  profile::types::file_and_mount { '/srv/gitolite':
    file_params => {
      'owner' => 'gitolite',
      'group' => 'gitolite',
    },
    mount_params  => {
      'ensure'  => mounted,
      'atboot'  => true,
      'device'  => $btrfs_host_volume,
      'fstype'  => btrfs,
      'options' => "defaults,subvol=${$btrfs_gitserver_subvolume}",
    },
    require  => [User['gitolite'], Subvolume[$btrfs_subvolume_path]],
    # before   => Class['Gitolite']
  }
}
