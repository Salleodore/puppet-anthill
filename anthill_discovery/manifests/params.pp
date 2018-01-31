
class anthill_discovery::params {

  $service_name = "discovery"

  $repository_remote_url = "https://github.com/anthill-platform/anthill-discovery.git"
  $source_directory = "${anthill::sources_location}/${service_name}"

  $services_init_file = "${anthill::runtime_location}/discovery-services.json"

  $discover_services_location = "redis-${hostname}"
  $discover_services_max_connections = $anthill::redis_default_max_connections
  $discover_services_db = 3

  $token_cache_location = "redis-${hostname}"
  $token_cache_max_connections = $anthill::redis_default_max_connections
  $token_cache_db = 4

  $enable_monitoring = $anthill::services_enable_monitoring
  $monitoring_location = $anthill::services_monitoring_location

  $internal_broker_location = "rabbitmq-${hostname}"
  $pubsub_location = "rabbitmq-${hostname}"
}