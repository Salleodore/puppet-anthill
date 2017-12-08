class anthill::dns (
  $backend = 'hosts',
  $interface = 'eth0'
) {
  $local_ip_address = inline_template("<%= scope.lookupvar('::ipaddress_${interface}') -%>")

  case $backend {
    "hosts": {
      class { anthill::dns::backend::hosts:

      }
    }
  }
}