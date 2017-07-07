# create an nxlog.conf extension
define nxlog::extension::kvp (
  $keyquotechar = undef,
  $valuequotechar = undef,
  $escapechar = undef,
  $kvdelimiter = undef,
  $kvpdelimiter = undef,
  $escapecontrol = undef,
  $schedule = undef,
) {
  if ! defined(Class['nxlog']) {
    fail('You must include the nxlog base class before using any nxlog defined resources')
  }

  $extension_name = $title
  validate_string($extension_name)

  file {"${nxlog::config::conf_dir}/extension_${extension_name}.conf":
    ensure  => present,
    content => template('nxlog/extension/kvp.conf.erb'),
    notify  => Class['nxlog::service'],
  }

}
