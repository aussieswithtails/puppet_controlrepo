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
  $btrfs_device = hiera('btrfs_device')  #ToDo - Currently lack of value causes failure of catalog.
                                              #Instead lack of value should result in failure of this profile only!
  $btrfs_admin_mountpoint = '/mnt/btrfs'
  $btrfs_vms_subvolume = '@vms'
  $vms_mountpoint = '/var/lib/vms'
  $btrfs_subvolume_path = "${btrfs_admin_mountpoint}/${btrfs_vms_subvolume}"

  include ::vagrant
  include ::virtualbox

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

  ensure_resource('profile::types::file_and_mount', $vms_mountpoint, {
    file_params  => { },
    mount_params => {
      'ensure'  => mounted,
      'atboot'  => true,
      'device'  => $btrfs_device,
      'fstype'  => 'btrfs',
      'options' => "defaults,subvol=${$btrfs_vms_subvolume}",
    },
    require     => [Subvolume[$btrfs_subvolume_path]],
  })


}

