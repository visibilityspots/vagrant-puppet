# Class: profiles::icinga2
#
# This class initializes a icinga2 instance

class profiles::icinga2 {
  include ::icinga2::server

  icinga2::object::idomysqlconnection { 'mysql_connection':
    target_dir       => '/etc/icinga2/features-enabled',
    target_file_name => 'ido-mysql.conf',
    host             => '127.0.0.1',
    port             => 3306,
    user             => 'icinga2',
    password         => 'icinga2',
    database         => 'icinga2',
  }
#  include ::icinga2::feature::command
}
