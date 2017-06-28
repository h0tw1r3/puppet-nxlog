# manages the nxlog service
#
# this class should not be called directly
class nxlog::service (
  $manage_service = $::nxlog::manage_service,
)
{
  if $manage_service {
    service {'nxlog':
      ensure => running,
      enable => true,
    }
  }
}
