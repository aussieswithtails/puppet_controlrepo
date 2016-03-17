define profile::types::file_and_mount (
  $atboot,
  $device,
  $dump,
  $fstype,
  $group,
  $mode,
  $options,
  $owner,
  $path = $title,
) {
  file { $name:
    ensure => 'directory',
    group  => $group,
    mode   => $mode,
    owner  => $owner,
    path   => $path,
  }
  mount { $name:
    ensure  => 'mounted',
    name    => $path,
    atboot  => $atboot,
    device  => $device,
    dump    => $dump,
    fstype  => $fstype,
    options => $options,
    require => File[$name],
    notify  => Exec['fix_mount_perms']
  }
  exec { 'fix_mount_perms':
    command => "chmod ${mode} ${name} && chown ${owner}:${group} ${name}",
    refreshonly => true,
  }
}
