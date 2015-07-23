# Class: profiles::opentracker
#
# This class initializes a opentracker instance

class profiles::opentracker (
  $initialize_data = false
)  {

  include ::repo::visibilityspots
  include ::opentracker

  if ::profiles::opentracker::initialize_data{

    package { 'random-torrent-data-generator':
      ensure => 'installed'
    }

    exec { 'initialize torrent data':
      command => '/usr/bin/random-torrent-data-generator -i',
      creates => '/var/www/html/torrents',
      require => [
        Package['random-torrent-data-generator'],
        Service['transmission-daemon']
      ]
    }
  }

}
