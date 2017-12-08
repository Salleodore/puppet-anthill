
define anthill::dns::entry (
  $internal_hostname,
  $internal_ip_address = $anthill::dns::local_ip_address
) {

  case $anthill::dns::backend {
    "hosts": {

      host { $internal_hostname:
        ensure => present,
        ip => $internal_ip_address,
        tag => "internal"
      }
    }
  }
}