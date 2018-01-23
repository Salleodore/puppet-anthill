
class anthill_social::params {

  $service_name = "social"

  $repository_remote_url = "https://github.com/anthill-platform/anthill-social.git"
  $source_directory = "${anthill::sources_location}/${service_name}"

  $db_location = "mysql-${hostname}"
  $db_name = "${environment}_${service_name}"

  $token_cache_location = "redis-${hostname}"
  $token_cache_max_connections = $anthill::redis_default_max_connections
  $token_cache_db = 4

  $cache_location = "redis-${hostname}"
  $cache_max_connections = $anthill::redis_default_max_connections
  $cache_db = 2

  $internal_broker_location = "rabbitmq-${hostname}"
  $pubsub_location = "rabbitmq-${hostname}"

  $nginx_max_body_size = '1024m'
}