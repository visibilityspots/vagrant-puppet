# Class: roles::icinga
#
# This role configures a icinga
class roles::icinga {

  if ! defined(Yumrepo['epel']){
    yumrepo { 'epel':
      descr      => 'Extra Packages for Enterprise Linux',
      baseurl    => 'http://download.fedoraproject.org/pub/epel/6/$basearch',
      mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
      gpgkey     => 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6',
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

}
