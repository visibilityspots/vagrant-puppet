# Class: roles::hubot
#
# This role configures a hubot
class roles::hubot {
  include ::profiles::nodejs
  include ::profiles::hubot

  Package['nodejs'] ->
  Package['npm'] ->
  Package['hubot']
}
