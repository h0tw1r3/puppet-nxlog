# use chocolatey to install nxlog msi
class nxlog::install (
  $manage_package = $::nxlog::manage_package
)
{
  if $manage_package {
    case $::osfamily {
      'Windows': {
        package {'nxlog':
          ensure   => present,
          provider => 'chocolatey',
        }
      }
      'RedHat': {
        package {'nxlog-ce':
          ensure  => present,
        }
      }
    }
  }

  # copy installer to client
  #file {"C:/tempinstall":
  #  ensure => directory
  #  }
  #file {"C:/tempinstall/nxlog-ce-2.9.1504.msi":
  #  ensure => present,
  #  source => "puppet:///modules/nxlog/nxlog-ce-2.9.1504.msi",
  #  require => File["C:/tempinstall"]
  #}
#
#  #package {'NXLog-CE':
#  #  ensure          => '2.9.1504',
#  #  source          => "C:/tempinstall/nxlog-ce-2.9.1504.msi",
#  #  install_options => ['ALLUSERS=1', '/qn', '/norestart'],
#  #  #require         => File["C:/tempinstall/nxlog-ce-2.9.1504.msi"]
  #}
}
