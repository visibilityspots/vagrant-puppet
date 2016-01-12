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
      ensure => 'installed',
      before => Package['nodejs']
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

  exec { 'initialize-ruby-env':
    command => 'scl enable ruby193 \'gem install --bindir /usr/bin --no-rdoc --no-ri dashing json\'',
    unless  => "scl enable ruby193 'gem list'| grep -qs dashing"
  }

}
