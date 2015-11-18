# Class: profiles::dashing
#
# This class initializes a dashing environment

class profiles::dashing {

  if $::virtual=='virtualbox' {
    augeas { 'enable_epel_repo':
      changes => [
        'set /files/etc/yum.repos.d/epel.repo/epel/enabled 1',
      ],
      before  => Package['nodejs']
    }
  } else {
    package { 'epel-release':
      ensure => 'installed'
    }
  }

  $packages = [
    'nodejs',
    'libuv',
    'http-parser',
    'zlib-devel'
  ]

  package { $packages:
    ensure => 'installed'
  }

  $gems = [
    'dashing',
    'json'
  ]

  package { $gems:
    ensure   => 'installed',
    provider => 'gem',
    notify   => Exec['extend_path']
  }

  exec { 'extend_path':
    command     => 'echo \'PATH=$PATH:/opt/rh/ruby193/root/usr/local/bin/\' >> /root/.bashrc',
    refreshonly => true
  }

}
