# create an nxlog.conf extension
define nxlog::extension::json {
  if ! defined(Class['nxlog']) {
    fail('You must include the nxlog base class before using any nxlog defined resources')
  }

  $extension_name = $title
  validate_string($extension_name)

  file {"${nxlog::config::conf_dir}/extension_${extension_name}.conf":
    ensure  => present,
    content => template('nxlog/extension/json.conf.erb'),
    notify  => Class['nxlog::service'],
  }

}
