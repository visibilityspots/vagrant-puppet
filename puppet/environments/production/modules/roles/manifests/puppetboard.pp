# Class: roles::puppetboard
#
# This role configures a puppetboard

class roles::puppetboard {

  if $::virtual=='virtualbox' {
    augeas { 'enable_epel_repo':
      changes => [
        'set /files/etc/yum.repos.d/epel.repo/epel/enabled 1',
      ],
      before  => Class['::puppetboard']
    }
  }
  include ::profiles::apache
  include ::profiles::puppetboard

}
