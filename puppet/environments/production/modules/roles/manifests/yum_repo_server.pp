# Class: roles::yum_repo_server
#
# This role declares a yum_repo_server service
class roles::yum_repo_server {

  include profiles::jetty
  include profiles::mongo
  include profiles::yum_repo_server
  include profiles::yum_repo_client

  Class['mongodb::service'] ->
  Class['::yum_repo_server::install'] ->
  Class['::yum_repo_client::install']
}
