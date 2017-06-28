# create an nxlog output config
#
# more info found at http://nxlog-ce.sourceforge.net/nxlog-docs/en/nxlog-reference-manual.html#modules_output

define nxlog::output (
  $output_module,
  $output_file    = undef,
  $output_host    = undef,
  $output_port    = undef,
  $output_execs   = undef,
  $output_type    = undef,
  $output_options = undef,
  $root           = $::nxlog::root
  )
  {
    if ! defined(Class['nxlog']) {
      fail('You must include the nxlog base class before using any nxlog defined resources')
      }

    $output_name = $title

    validate_string($output_name)
    validate_re($output_module, ['^blocker$','^pm_dbi$', '^exec$', '^file$', '^http$', '^null$', '^ssl$', '^tcp$', '^udp$', '^uds$'])
    validate_legacy(Optional[Integer]), 'validate_integer', $output_port)
    validate_legacy(Optional[Array], 'validate_array', $output_execs)

    file {"${nxlog::config::conf_dir}/${output_name}.conf":
      ensure  => present,
      content => template('nxlog/output.erb')
    }

}
