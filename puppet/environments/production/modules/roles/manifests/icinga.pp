# Class: roles::icinga
#
# This role configures a icinga
class roles::icinga {

  if ! defined(Yumrepo['epel']){
    yumrepo { 'epel':
      descr      => 'Extra Packages for Enterprise Linux',
      baseurl    => 'http://download.fedoraproject.org/pub/epel/7/$basearch',
      mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch',
      gpgkey     => 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7',
      enabled    => 1,
      gpgcheck   => 1;
    }
  }

  include ::profiles::mysql
  include ::profiles::icinga2
  include ::profiles::icingaweb2

#  Icinga2::Object::Host <<| |>> { }
#
#  @@icinga2::object::host { $::fqdn:
#    display_name     => $::fqdn,
#    ipv4_address     => $::ipaddress_eth0,
#    vars             => {
#      os              => 'linux',
#      virtual_machine => true,
#      distro          => $::operatingsystem,
#    },
#    target_dir       => '/etc/icinga2/objects/hosts',
#    target_file_name => "${::fqdn}.conf"
#  }

  Mysql::Db[$::icinga2::server::db_name] ->
  Class['::icinga2::server::install::execs']
}
