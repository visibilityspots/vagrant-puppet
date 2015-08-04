# Class: profiles::hubot
#
# This class initializes a hubot instance

class profiles::hubot {
  include ::repo::visibilityspots
  include ::hubot

}
