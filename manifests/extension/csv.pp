# create an nxlog.conf extension
define nxlog::extension::csv (
  $fields,
  $fieldtypes = undef,
  $quotechar = undef,
  $escapechar = undef,
  $delimiter = undef,
  $quotemethod = undef,
  $escapecontrol = undef,
  $undefvalue = undef,
  $schedule = undef,
) {
  if ! defined(Class['nxlog']) {
    fail('You must include the nxlog base class before using any nxlog defined resources')
  }

  $extension_name = $title
  validate_string($extension_name)

  if ! match(['string','all','none'], $quotemethod) {
    fail('Invalid quotemethod')
  }

  file {"${nxlog::config::conf_dir}/extension_${extension_name}.conf":
    ensure  => present,
    content => template('nxlog/extension/csv.conf.erb'),
    notify  => Class['nxlog::service'],
  }

}
