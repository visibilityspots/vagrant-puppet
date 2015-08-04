# Class: profiles::nodejs
#
# This class initializes nodejs

class profiles::nodejs {
  include ::repo::epel
  include ::nodejs

  Yumrepo['epel'] ->
  Package['nodejs']
}
