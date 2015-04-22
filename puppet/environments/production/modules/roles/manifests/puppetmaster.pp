# Class: roles::puppetmaster
#
# This role configures a puppetmaster

class roles::puppetmaster {

  $puppet_server = hiera('puppet::server_implementation')

  yumrepo { 'epel':
    descr          => 'Extra Packages for Enterprise Linux 6 - $basearch',
    baseurl        => 'http://download.fedoraproject.org/pub/epel/6/$basearch',
    mirrorlist     => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
    failovermethod => 'priority',
    enabled        => false,
    gpgcheck       => '0',
  }

  if $::virtual=='virtualbox' {
    augeas { 'enable_puppetlabs_repo':
      changes => [
        'set /files/etc/yum.repos.d/puppetlabs.repo/puppetlabs/enabled 1',
      ],
      before  => Class['::puppet::server::service']
    }
  }

  augeas { 'enable_auto_sign':
    changes => [
      'set /files/etc/puppet/puppet.conf/master/autosign true',
    ],
    require => Class['::puppet::server::config'],
    notify  => Service[$puppet_server]
  }

  include ::profiles::puppet
  include ::profiles::puppetdb

  Class['::puppet::server::service'] ->
  Class['::puppetdb::server']
}
