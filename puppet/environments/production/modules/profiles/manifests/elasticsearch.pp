# Class: profiles::elasticsearch
#
# This profile initializes an elasticsearch instance
class profiles::elasticsearch {

  include ::elasticsearch
  create_resources(
    ::elasticsearch::instance, hiera_hash('elasticsearch::instance')
  )
}
