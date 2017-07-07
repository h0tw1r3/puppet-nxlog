# create an nxlog output config
define nxlog::output::exec (
  $command,
  $outputtype,
  $arg = undef,
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
    content => template('nxlog/output/exec.erb'),
    notify  => Class['nxlog::service'],
  }

}
