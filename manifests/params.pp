# set the default values
class nxlog::params {
  # possible extension modules
  $extensions = ['csv','json','xml','kvp','gelf','charconv','fileop','multiline','syslog','exec','perl','wtmp']
  case $::osfamily {
    'Windows': {
      $root           = "C:\\Program Files (x86)\\nxlog"
      $module_dir     = '%ROOT%\modules'
      $cache_dir      = '%ROOT%\data'
      $pid_file       = '%ROOT%\data\nxlog.pid'
      $spool_dir      = '%ROOT%\data'
      $log_file       = '%ROOT%\data\nxlog.log'
      $log_level      = 'INFO'
      $user           = undef
      $group          = undef
      $manage_service = true
      $manage_package = true
      $package_name   = 'nxlog'
      $service_name   = 'nxlog'
    }
    'RedHat': {
      $root           = undef
      $module_dir     = '/usr/libexec/nxlog/modules'
      $cache_dir      = '/var/spool/nxlog'
      $pid_file       = '/var/run/nxlog/nxlog.pid'
      $spool_dir      = '/var/spool/nxlog'
      $log_file       = '/var/log/nxlog/nxlog.log'
      $log_level      = 'INFO'
      $user           = 'nxlog'
      $group          = 'nxlog'
      $manage_service = true
      $manage_package = true
      $package_name   = 'nxlog-ce'
      $service_name   = 'nxlog'
    }
    default: {
      notify("Unsupported OS family ${::osfamily}")
    }
  }
}
