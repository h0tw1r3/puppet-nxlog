# create an input in nxlog.conf
define nxlog::input::null {
  if ! defined(Class['nxlog']) {
    fail('You must include the nxlog base class before using any nxlog defined resources')
  }

  $input_name = $title
  validate_string($input_name)

  file {"${nxlog::config::conf_dir}/input_${input_name}.conf":
    ensure  => present,
    content => template('nxlog/input/null.erb'),
    notify  => Class['nxlog::service'],
  }
}
