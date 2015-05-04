# Class: roles::puppetmaster
#
# This role configures a puppetmaster

class roles::puppetmaster {

  $puppet_server = hiera('puppet::server_implementation')

  if $::virtual=='virtualbox' {
    augeas { 'enable_puppetlabs_repo':
      changes => [
        'set /files/etc/yum.repos.d/puppetlabs.repo/puppetlabs/enabled 1',
      ],
      before  => Class['::puppet::server::service']
    }
  }

  include ::profiles::puppet
  include ::profiles::puppetdb

  Class['::puppet::server::service'] ->
  Class['::puppetdb::server']
}
