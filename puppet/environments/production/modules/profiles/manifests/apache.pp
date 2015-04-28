# Class: profiles::apache
#
# This class initializes a apache instance

class profiles::apache {
  include ::apache
  include ::apache::mod::wsgi
}
