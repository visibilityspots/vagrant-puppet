# Class: repo::visibilityspots
#
# This class will set up the visibilityspots repository
class repo::visibilityspots {

  case $::operatingsystem {
    'CentOS', 'RedHat', 'Scientific', 'OEL', 'Amazon': {
      yumrepo { 'visibilityspots':
        descr       => 'Visibilityspots yum-repo-server',
        baseurl    => 'https://packagecloud.io/visibilityspots/yum-repo-server/el/6/$basearch',
        gpgkey     => 'https://packagecloud.io/gpg.key',
        enabled    => 1,
        gpgcheck   => 0;
      }
    }
    default: {
      fail('Operating system not supported.')
    }
  }
}
