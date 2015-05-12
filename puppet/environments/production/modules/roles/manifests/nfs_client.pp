# Class: roles::nfs_client
#
# This role configures an NFS client

class roles::nfs_client {
  include ::profiles::nfs_client
}
