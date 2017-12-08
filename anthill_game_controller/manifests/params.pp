
class anthill_game_controller::params {

  $service_name = "game-ctl"

  $repository_remote_url = "https://github.com/anthill-platform/anthill-game-controller.git"
  $source_directory = "${anthill::sources_location}/${service_name}"

  $sock_path = "/tmp"
  $binaries_path = "${anthill::runtime_location}/${service_name}-gameserver"
  $ports_pool_from = "38000"
  $ports_pool_to = "40000"

  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = $anthill::redis_default_max_connections
  $token_cache_db = 4

  $service_directory_name = "game"

  $gs_host = "${service_name}-${environment}.${anthill::external_domain_name}"

  $nginx_max_body_size = '1024m'
}