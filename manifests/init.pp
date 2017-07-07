# == Class: nxlog
#
# === Parameters:
#
# $root::                     root folder for nxlog
#                             type: string
# 
# $module_dir::               module directory
#                             type: string
# 
# $cache_dir::                cache directory
#                             type: string
# 
# $pid_file::                 pif file location
#                             type: string
# 
# $spool_dir::                spool directory
#                             type: string
# 
# $log_file::                 log file location
#                             type: string
# 
# $extensions::                 extensions to be installed. Allowed extensions are:
#                             - csv
#                             - json
#                             - xml
#                             - kvp
#                             - gelf
#                             - charconv
#                             - fileop
#                             - multiline
#                             - syslog
#                             - exec
#                             - perl
#                             - wtmp
#                             type: array
# $
class nxlog (
  $root           = $nxlog::params::root,
  $module_dir     = $nxlog::params::module_dir,
  $cache_dir      = $nxlog::params::cache_dir,
  $pid_file       = $nxlog::params::pid_file,
  $spool_dir      = $nxlog::params::spool_dir,
  $log_file       = $nxlog::params::log_file,
  $log_level      = $nxlog::params::log_level,
  $user           = $nxlog::params::user,
  $group          = $nxlog::params::group,
  $manage_service = $nxlog::params::manage_service,
  $manage_package = $nxlog::params::manage_package,
  $service_name   = $nxlog::params::service_name,
  $package_name   = $nxlog::params::package_name,
  $extensions     = $nxlog::params::extensions,
  )inherits nxlog::params
  {
  class {'nxlog::install':}
  ->
  class {'nxlog::config':}
  ~>
  class {'nxlog::service':}
}
