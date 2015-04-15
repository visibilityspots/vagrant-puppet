# Class: profiles::puppetdb
#
# This class initializes a puppetdb instance

class profiles::puppetdb {
  include ::puppetdb
  include ::puppetdb::master::config
}
