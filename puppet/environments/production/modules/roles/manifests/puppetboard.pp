# Class: roles::puppetboard
#
# This role configures a puppetboard

class roles::puppetboard {

  if $::virtual=='virtualbox' {
    augeas { 'enable_epel_repo':
      changes => [
        'set /files/etc/yum.repos.d/epel.repo/epel/enabled 1',
      ],
      before  => Class['::puppetboard']
    }
  } else {
      yumrepo { 'epel':
        descr      => 'Extra Packages for Enterprise Linux',
        mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
        gpgkey     => 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6',
        enabled    => 1,
        gpgcheck   => 1;
      }
  }

  include ::profiles::apache
  include ::profiles::puppetboard
}
