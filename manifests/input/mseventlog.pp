# create an input in nxlog.conf
define nxlog::input::mseventlog (
  $savepos = undef,
  $readfromlast = undef,
  $sources = undef,
  $utf8 = undef,
  $flowcontrol = undef,
  $schedule = undef,
  $exec = undef,
  $root    = $::nxlog::root,
) {
  if ! defined(Class['nxlog']) {
    fail('You must include the nxlog base class before using any nxlog defined resources')
  }

  $input_name = $title
  validate_string($input_name)
  validate_legacy(Optional[Bool], 'validate_bool', $flowcontrol)
  validate_legacy(Optional[Array], 'validate_array', $exec)
  validate_legacy(Optional[Array], 'validate_array', $schedule)

  file {"${nxlog::config::conf_dir}/input_${input_name}.conf":
    ensure  => present,
    content => template('nxlog/input/mseventlog.erb'),
    notify  => Class['nxlog::service'],
  }
}
