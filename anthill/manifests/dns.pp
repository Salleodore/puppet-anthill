class anthill::dns (
  $backend = 'hosts',
  $interface = undef
) {

  case $backend {
    "hosts": {
      class { anthill::dns::backend::hosts:

      }
    }
  }
}