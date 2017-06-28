# create an nxlog.conf route
# more info found at http://nxlog-ce.sourceforge.net/nxlog-docs/en/nxlog-reference-manual.html#config_routes

define nxlog::route (
  $route_source,
  $route_destination,
  $route_priority = undef,
  $root           = $::nxlog::root
  )
{
  if ! defined(Class['nxlog']) {
      fail('You must include the nxlog base class before using any nxlog defined resources')
      }

  $route_name = $title

  validate_string($route_name)

  file {"${nxlog::config::conf_dir}/${route_name}.conf":
      ensure  => present,
      content => template('nxlog/route.erb')
  }

}
