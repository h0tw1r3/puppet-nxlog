# create an nxlog.conf processor
define nxlog::processor::transformer (
  $inputformat,
  $csvinputfields     = undef,
  $csvinputfieldtypes = undef,
  $outputformat       = undef,
  $csvoutputfields    = undef,
  $flowcontrol = undef,
  $schedule    = undef,
  $exec        = undef,
) {
  if ! defined(Class['nxlog']) {
    fail('You must include the nxlog base class before using any nxlog defined resources')
  }

  $processor_name = $title
  validate_string($processor_name)

  file { "${nxlog::config::conf_dir}/processor_${processor_name}.conf":
    ensure  => present,
    content => template('nxlog/processor/transformer.conf.erb'),
    require => File[$patternfile],
    notify  => Class['nxlog::service'],
  }

}
