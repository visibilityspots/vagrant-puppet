# Class: profiles::overpass_api
#
# This class initializes a overpass_api instance

class profiles::overpass_api {
  include ::repo::visibilityspots
  include ::overpass_api
}
