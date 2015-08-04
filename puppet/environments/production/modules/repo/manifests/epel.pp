# Class: repo::epel
#
# This class will set up the epel repository
class repo::epel {
  case $::operatingsystem {
    'CentOS', 'RedHat', 'Scientific', 'OEL', 'Amazon': {

      if $::virtual=='virtualbox' {
        augeas { 'enable_epel_repo':
          changes => [
            'set /files/etc/yum.repos.d/epel.repo/epel/enabled 1',
          ],
        }
      } else {
        yumrepo { 'epel':
          descr       => 'Extra Packages for Enterprise Linux',
          baseurl    => 'http://download.fedoraproject.org/pub/epel/6/$basearch',
          mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
          gpgkey     => 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6',
          enabled    => 1,
          gpgcheck   => 1;
        }
      }
    }
    default: {
      fail('Operating system not supported.')
    }
  }
}
