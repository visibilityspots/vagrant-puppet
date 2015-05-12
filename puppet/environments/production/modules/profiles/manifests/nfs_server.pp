# Class: profiles::nfs_server
#
# This class initializes an NFS server

class profiles::nfs_server {
  $depending_directories = hiera('directories')
  create_resources(file, $depending_directories)

  include ::lvm

  include ::nfs::server

  $nfs_exports = hiera('exports')
  create_resources(nfs::server::export, $nfs_exports)
}
