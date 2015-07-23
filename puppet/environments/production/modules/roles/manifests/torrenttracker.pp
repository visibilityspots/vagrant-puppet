# Class: roles::torrenttracker
#
# This role configures a torrenttracker
class roles::torrenttracker {

  define create_webstructure {
    if ! defined( File[$name]) {
      file { $name:
        ensure => directory,
      }
    }
  }

  $web_structure = [ '/var/www/', '/var/www/html/' ]
  create_webstructure { $web_structure: }

  include ::profiles::transmission
  include ::profiles::nginx
  include ::profiles::opentracker

}
