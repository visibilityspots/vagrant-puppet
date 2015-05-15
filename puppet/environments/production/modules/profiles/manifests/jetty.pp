# Class: profiles::jetty
#
# This profile initializes the jetty service
class profiles::jetty {

  user { 'jetty':
    ensure => 'present'
  }

  include repo::visibilityspots
  include ::jetty

  User['jetty'] ->
  Class['::jetty::install']

}
