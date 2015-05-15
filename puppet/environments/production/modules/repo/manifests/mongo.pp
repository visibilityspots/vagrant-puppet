# Class: repo::mongo
#
# This class will set up the mongodb repository
class repo::mongo {

  case $::operatingsystem {
    'CentOS', 'RedHat', 'Scientific', 'OEL', 'Amazon': {
      yumrepo {
        'mongodb':
          descr    => 'MongoDB.org repository',
          baseurl  => 'http://downloads-distro.mongodb.org/repo/redhat/os/x86_64',
          enabled  => 1,
          gpgcheck => 0;
      }
    }
    default: {
      fail('Operating system not supported.')
    }
  }
}
