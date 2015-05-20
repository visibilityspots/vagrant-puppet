# Class: roles::puppetmaster
#
# This role configures a puppetmaster
class roles::puppetmaster {

  if $::virtual=='virtualbox' {
    augeas { 'enable_puppetlabs_repo':
      changes => [
        'set /files/etc/yum.repos.d/puppetlabs.repo/puppetlabs/enabled 1',
      ],
      before  => Class['::puppet::server::service']
    }
  }

  if $puppet::server_implementation != 'puppetserver' {
    if ! defined(Yumrepo['epel']){
      yumrepo { 'epel':
        descr      => 'Extra Packages for Enterprise Linux',
        baseurl    => 'http://download.fedoraproject.org/pub/epel/6/$basearch',
        mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
        gpgkey     => 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6',
        enabled    => 1,
        gpgcheck   => 1;
      }
    }
  }

  include ::profiles::puppet
  include ::profiles::puppetdb

  Class['::puppet::server::service'] ->
  Class['::puppetdb::server']
}
