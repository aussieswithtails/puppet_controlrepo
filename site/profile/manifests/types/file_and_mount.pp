define profile::types::file_and_mount (
  $file_params,
  $mount_params,
) {
  $owner = pick_default($file_params['owner'], 'root')
  $group = pick_default($file_params['group'], 'root')
  $mode = pick_default($file_params['mode'], '0755')
  file { $name:
    ensure  => directory,
    * => $file_params,
  }
  mount { $name:
    * => $mount_params,
    require => File[$name],
    notify  => Exec["fix ${name} perms"]
  }
  exec { "fix ${name} perms":
    command => "/bin/chmod ${mode} ${name} && /bin/chown ${owner}:${group} ${name}",
    # command => "/usr/bin/ls ${name}",
    refreshonly => true,
  }
}
