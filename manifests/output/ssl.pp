# create an nxlog output config
define nxlog::output::ssl (
  $host,
  $port,
  $outputtype,
  $certfile = undef,
  $certkeyfile = undef,
  $keypass = undef,
  $cafile = undef,
  $cadir = undef,
  $crlfile = undef,
  $crldir = undef,
  $allowuntrusted = False,
  $schedule = undef,
  $exec = undef,
) {
  if ! defined(Class['nxlog']) {
    fail('You must include the nxlog base class before using any nxlog defined resources')
  }

  $output_name = $title
  validate_string($output_name)

  file {"${nxlog::config::conf_dir}/output_${output_name}.conf":
    ensure  => present,
    content => template('nxlog/output/ssl.erb'),
    notify  => Class['nxlog::service'],
  }

}
