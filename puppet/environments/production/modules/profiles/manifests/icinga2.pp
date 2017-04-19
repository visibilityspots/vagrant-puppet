# Class: profiles::icinga2
#
# This class initializes a icinga2 instance

class profiles::icinga2 {
  include ::icinga2

  icinga2::feature::idomysql { 'mysql_connection':
    user          => 'icinga2',
    password      => 'icinga2',
    database      => 'icinga2',
    import_schema => true,
    require       => Mysql::Db['icinga2'],
  }
#  include ::icinga2::feature::command
}
