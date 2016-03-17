class profile::git::gitolite {
  notify {"Applying profile: profile::git::gitolite": }

  include gitolite

  user {'gitolite':
    ensure  => present,
    home    => '/srv/gitolite',
    managehome => true,
    name    => 'gitolite',
    shell   => '/usr/sbin/nologin',
    system  => true,

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

#  # Create The BTRFS Subvolume
  file {['/mnt', '/mnt/btrfs']:
    ensure  => directory
  }

  mount { $btrfs_admin_mountpoint:
    ensure => mounted,
    device => $btrfs_host_volume,
    fstype => 'btrfs',
    require => File['/mnt/btrfs']
  }

  subvolume { $btrfs_subvolume_path: #FixMe - I don't like syntax here. Should be a parameter that specifies
    ensure  => present,              # path to where btrfs is mounted
    require  => Mount[$btrfs_admin_mountpoint]
  }

  profile::types::file_and_mount {$gitolite_mountpoint:
    owner => 'gitolite',
    group => 'gitolite',
    mode  => '0750',
    atboot  => true,
    device  => $btrfs_host_volume,
    fstype   => 'btrfs',
    options => "defaults,subvol=${$btrfs_gitserver_subvolume}",
    dump    => 0,
    require => Subvolume[$btrfs_subvolume_path],
    before  => Class['Gitolite']
  }
#  file {$gitolite_mountpoint:
#    ensure  => directory,
#  }
#
#  mount { $gitolite_mountpoint:
#    ensure  => mounted,
#    device  => $btrfs_host_volume,
#    fstype  => 'btrfs',
#    options => "defaults,subvol=${$btrfs_gitserver_subvolume}",
#    pass    => 2,
##    require => Subvolume[ $btrfs_subvolume_path],
#    require => File[ $gitolite_mountpoint],
#    notify  => File['post_subvolume_mount'],
#    before  => Class['Gitolite::Config']
#  }
#
#  File['post_subvolume_mount'] {
#    path  => $gitolite_mountpoint,
#  group   => 'gitolite',
#  mode    => '0755',
#  owner   => 'gitolite',
#  require => User['gitolite']
#  }
}