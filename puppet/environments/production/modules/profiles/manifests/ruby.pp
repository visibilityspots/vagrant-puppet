# Class: profiles::ruby
#
# This class initializes a ruby environment

class profiles::ruby {

  package { 'centos-release-SCL':
    ensure => 'present'
  }

  $ruby193_soft=['ruby193','ruby193-ruby-devel','gcc-c++']

  package { $ruby193_soft:
    ensure  => 'present',
    require => Package['centos-release-SCL'],
    before  => Exec['make-ruby193-default']
  }

  exec { 'make-ruby193-default':
    command => 'echo "source /opt/rh/ruby193/enable" | sudo tee -a /etc/profile.d/ruby193.sh',
    creates => '/etc/profile.d/ruby193.sh'
  }

}
