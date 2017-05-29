
class anthill_game::master::params {

  $service_name = "game"

  $deployments_path = "${anthill::applications_location}/${environment}-deployments"

  $db_host = $anthill::mysql::mysql_host
  $db_username = $anthill::mysql::mysql_username
  $db_password = $anthill::mysql::mysql_password
  $db_name = "${environment}_${service_name}"

  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = 500
  $token_cache_db = 28

  $cache_host = $anthill::redis::host
  $cache_port = $anthill::redis::port
  $cache_max_connections = 500
  $cache_db = 29

  $rate_cache_host = $anthill::redis::host
  $rate_cache_port = $anthill::redis::port
  $rate_cache_max_connections = 500
  $rate_cache_db = 29

  $nginx_max_body_size = '1024m'
}