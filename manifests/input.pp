# create an input in nxlog.conf
define nxlog::input (
  $input_module,
  $query         = undef,
  $root          = $::nxlog::root,
  $input_file    = undef,
  $savepos       = true,
  $input_type    = undef,
  $input_execs   = undef,
  $input_port    = undef,
  $input_options = undef,
  )
{
  if ! defined(Class['nxlog']) {
      fail('You must include the nxlog base class before using any nxlog defined resources')
      }

  $input_name = $title

  validate_string($input_name)
  validate_re($input_module,
    ['^dbi$', '^exec$', '^file$', '^internal$', '^kernel$', '^mark$', '^mseventlog$',
    '^msvistalog$', '^null$', '^ssl$', '^tcp$', '^udp$', '^uds$'])
  validate_string($query)

  validate_legacy(Optional[Integer]), 'validate_integer', $input_port)
  validate_legacy(Optional[Array], 'validate_array', $input_execs)

  file {"${nxlog::config::conf_dir}/${input_name}.conf":
      ensure  => present,
      content => template('nxlog/input.erb'),
      notify  => Service['nxlog']
    }
}
