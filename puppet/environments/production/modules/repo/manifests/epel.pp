# Class: repo::epel
#
# This class will set up the epel repository
class repo::epel {

  case $::operatingsystem {
    'CentOS', 'RedHat', 'Scientific', 'OEL', 'Amazon': {
      yumrepo { 'epel':
        descr       => 'Extra Packages for Enterprise Linux',
        baseurl    => 'http://download.fedoraproject.org/pub/epel/6/$basearch',
        mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
        gpgkey     => 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6',
        enabled    => 1,
        gpgcheck   => 1;
      }
    }
    default: {
      fail('Operating system not supported.')
    }
  }
}
