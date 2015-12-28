# Class: profiles::icinga2
#
# This class initializes a icinga2 instance

class profiles::icinga2 {
  include ::icinga2
  include ::icinga2::feature::command
}
