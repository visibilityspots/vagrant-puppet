# Class: profiles::puppetboard
#
# This class initializes a puppetboard instance

class profiles::puppetboard {
  include ::puppetboard
  include ::puppetboard::apache::conf
}
