# create an nxlog output config
define nxlog::output::http (
  $url,
  $httpscertfile = undef,
  $httpscertkeyfile = undef,
  $httpskeypass = undef,
  $httpscafile = undef,
  $httpscadir = undef,
  $httpscrlfile = undef,
  $httpscrldir = undef,
  $httpsallowuntrusted = False,
  $contenttype = 'text/plain',
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
    content => template('nxlog/output/http.erb'),
    notify  => Class['nxlog::service'],
  }

}
