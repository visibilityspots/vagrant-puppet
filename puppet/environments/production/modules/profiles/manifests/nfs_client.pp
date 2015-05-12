# Class: profiles::nfs_client
#
# This class initializes an NFS client

class profiles::nfs_client {

  include ::nfs::client

  $nfs_mounts = hiera('mounts')
  create_resources(nfs::client::mount, $nfs_mounts)
}
