
class anthill_game::controller::params {

  $service_name = "game-ctl"

  $sock_path = "/tmp"
  $binaries_path = "${anthill::applications_location}/${environment}-gameserver"
  $ports_pool_from = "38000"
  $ports_pool_to = "40000"

  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = 500
  $token_cache_db = 28

  $service_directory_name = "game"

  $gs_host = "${service_name}-${environment}.${anthill::external_domain_name}"

  $nginx_max_body_size = '1024m'
}