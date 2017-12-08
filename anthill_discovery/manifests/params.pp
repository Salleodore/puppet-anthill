
class anthill_discovery::params {

  $service_name = "discovery"

  $repository_remote_url = "https://github.com/anthill-platform/anthill-discovery.git"
  $source_directory = "${anthill::sources_location}/${service_name}"

  $discover_services_host = $anthill::redis::host
  $discover_services_port = $anthill::redis::port
  $discover_services_max_connections = $anthill::redis_default_max_connections
  $discover_services_db = 3

  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = $anthill::redis_default_max_connections
  $token_cache_db = 4

}