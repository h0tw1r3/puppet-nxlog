# create an nxlog.conf processor
define nxlog::processor::buffer (
  $maxsize,
  $type,
  $warnlimit   = undef,
  $directory   = undef,
  $flowcontrol = undef,
  $schedule    = undef,
  $exec        = undef,
) {
  if ! defined(Class['nxlog']) {
    fail('You must include the nxlog base class before using any nxlog defined resources')
  }

  $processor_name = $title
  validate_string($processor_name)

  # type in ['disk','mem']
  # if type == disk, directory is required

  file { "${nxlog::config::conf_dir}/processor_${processor_name}.conf":
    ensure  => present,
    content => template('nxlog/processor/buffer.conf.erb'),
    notify  => Class['nxlog::service'],
  }

}
