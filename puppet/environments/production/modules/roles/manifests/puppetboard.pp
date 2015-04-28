# Class: roles::puppetboard
#
# This role configures a puppetboard

class roles::puppetboard {

  include ::profiles::apache
  include ::profiles::puppetboard

}
