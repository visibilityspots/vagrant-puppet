# Class: profiles::yum_repo_client
#
# This profile initializes the yum-repo-client service
class profiles::yum_repo_client {

  include ::repo::epel
  include ::yum_repo_client
}
