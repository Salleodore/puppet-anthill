
class anthill_game_master::params {

  $service_name = "game"

  $repository_remote_url = "https://github.com/anthill-platform/anthill-game-master.git"
  $source_directory = "${anthill::sources_location}/${service_name}"

  $deployments_path = "${anthill::runtime_location}/${service_name}-deployments"

  $db_host = $anthill::mysql::mysql_host
  $db_username = $anthill::mysql::mysql_username
  $db_password = $anthill::mysql::mysql_password
  $db_name = "${environment}_${service_name}"

  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = $anthill::redis_default_max_connections
  $token_cache_db = 4

  $cache_host = $anthill::redis::host
  $cache_port = $anthill::redis::port
  $cache_max_connections = $anthill::redis_default_max_connections
  $cache_db = 2

  $rate_cache_host = $anthill::redis::host
  $rate_cache_port = $anthill::redis::port
  $rate_cache_max_connections = $anthill::redis_default_max_connections
  $rate_cache_db = 5

  $nginx_max_body_size = '1024m'

  $party_broker = "amqp://${anthill::rabbitmq::username}:${anthill::rabbitmq::password}@${anthill::rabbitmq::host}:${anthill::rabbitmq::port}/${environment}"
}