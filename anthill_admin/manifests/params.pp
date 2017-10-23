
class anthill_admin::params {

  $service_name = "admin"

  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = 500
  $token_cache_db = 9

  $cache_host = $anthill::redis::host
  $cache_port = $anthill::redis::port
  $cache_max_connections = 500
  $cache_db = 10

  $nginx_max_body_size = '1024m'
}