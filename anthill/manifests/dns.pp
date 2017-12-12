class anthill::dns (
  $backend = 'hosts',
  $interface = undef
) {

  if defined (Class[Anthill::Vpn]) {
    $local_ip_address = $anthill::vpn::ip
  } else {
    $local_ip_address = inline_template("<%= scope.lookupvar('::ipaddress_eth0') -%>")
  }


  case $backend {
    "hosts": {
      class { anthill::dns::backend::hosts:

      }
    }
  }
}