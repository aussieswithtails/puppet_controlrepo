class profile::git::gitolite {
  include gitolite

  $btrfs_host_volume = hiera('btrfs_device')  #ToDo - Currently lack of value causes failure of catalog.
  #Instead lack of value should result in failure of this profile only!
  $btrfs_admin_mountpoint = hiera('profile::btrfs::admin_mountpoint')
  $btrfs_gitserver_subvolume = '@gitolite'
  $gitolite_mountpoint = $::gitolite::home_dir
  $btrfs_subvolume_path = "${btrfs_admin_mountpoint}/${btrfs_gitserver_subvolume}"

  # Create The Subvolume
  file {['/mnt', '/mnt/btrfs']:
    ensure  => directory
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

  # Mount the subvolume
  file {$gitolite_mountpoint:
    ensure  => directory,
    group   => $::gitolite::group_name,
    mode    => '0755',
    owner   => $::gitolite::user_name,
    before  => Mount[$gitolite_mountpoint]
  }

  mount { $gitolite_mountpoint:
    ensure  => mounted,
    device  => $btrfs_host_volume,
    fstype  => 'btrfs',
    options => "defaults,subvol=${$btrfs_gitserver_subvolume}",
    pass    => 2,
    require => Subvolume[ $btrfs_subvolume_path],
    before  => Class['gitolite::config']
  }


}