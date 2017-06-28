# place the nxlog.conf config file
#
# this private class is not intended to be called directly

class nxlog::config (
  $root           = $::nxlog::root,
  $module_dir     = $::nxlog::module_dir,
  $cache_dir      = $::nxlog::cache_dir,
  $pid_file       = $::nxlog::pid_file,
  $spool_dir      = $::nxlog::spool_dir,
  $log_file       = $::nxlog::log_file,
  $log_level      = $::nxlog::log_level,
  $extensions     = $::nxlog::extensions,
  $user           = $::nxlog::user,
  $group          = $::nxlog::group,
  )
  {
  assert_private()

  case $::osfamily {
    'Windows': {
      $conf_dir = "${root}/conf.d"
      $conf_file = "${root}/conf/nxlog.conf"
    }
    default: {
      $conf_dir = "${root}/etc/nxlog.d"
      $conf_file = "${root}/etc/nxlog.conf"

      File<|title == $conf_dir|> {
        owner   => $user,
        group   => $group,
        mode    => '0750',
      }
      File<|title == $conf_file|> {
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
      }
    }
  }

  file { $conf_dir:
    ensure  => directory,
    require => Class['nxlog::install']
  }
  file { $conf_file:
    ensure  => present,
    content => template('nxlog/nxlog.conf.erb'),
    require => Class['nxlog::install']
  }

}
