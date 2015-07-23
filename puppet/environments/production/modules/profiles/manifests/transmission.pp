# Class: profiles::transmission
#
# This class initializes a transmission instance

class profiles::transmission {

  include ::repo::epel
  include ::transmission

  Class['::repo::epel'] ->
  Class['::transmission']

}
