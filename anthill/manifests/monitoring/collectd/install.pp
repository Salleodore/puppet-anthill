
class anthill::monitoring::collectd::install inherits anthill::monitoring::collectd {

  class { collectd:
    package_ensure => $ensure,
    purge_config => true,
    manage_package => true,
    fqdnlookup => false,
    collectd_hostname => $::fqdn,
    interval => 60
  }

}