
class anthill_discovery::params {

  $service_name = "discovery"

  $discover_services_host = $anthill::redis::host
  $discover_services_port = $anthill::redis::port
  $discover_services_max_connections = 500
  $discover_services_db = 3

  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = 500
  $token_cache_db = 4

}