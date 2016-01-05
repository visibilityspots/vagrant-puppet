# Class: profiles::icingaweb2
#
# This class initializes a icingaweb2 instance

class profiles::icingaweb2 {
  include ::apache
  include ::apache::mod::php

  augeas { 'php.ini':
    notify  => Service[httpd],
    require => Package[php],
    context => '/files/etc/php.ini/PHP',
    changes => [
      'set date.timezone Europe/Brussels',
    ];
  }

  include ::icingaweb2
  include ::icingaweb2::mod::monitoring
}
