# create an nxlog.conf route
define nxlog::route (
  $path,
  $priority = undef,
  $root     = $::nxlog::root
  )
{
  if ! defined(Class['nxlog']) {
      fail('You must include the nxlog base class before using any nxlog defined resources')
  }

  $route_name = $title
  validate_string($route_name)

  file {"${nxlog::config::conf_dir}/route_${route_name}.conf":
    ensure  => present,
    content => template('nxlog/route.conf.erb'),
    notify  => Class['nxlog::service'],
  }

}
