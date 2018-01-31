
class anthill_game_controller::params {

  $service_name = "game_controller"

  $repository_remote_url = "https://github.com/anthill-platform/anthill-game-controller.git"
  $source_directory = "${anthill::sources_location}/${service_name}"

  $sock_directory = "/tmp"
  $binaries_directory = "${anthill::runtime_location}/${service_name}-gameserver"
  $ports_pool_from = 38000
  $ports_pool_to = 40000

  $token_cache_location = "redis-${hostname}"
  $token_cache_max_connections = $anthill::redis_default_max_connections
  $token_cache_db = 4

  $gs_host = "${service_name}-${environment}.${anthill::external_domain_name}"

  $internal_broker_location = "rabbitmq-${hostname}"
  $pubsub_location = "rabbitmq-${hostname}"

  $nginx_max_body_size = '1024m'
}