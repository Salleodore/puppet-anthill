
class anthill_message::params {

  $service_name = "message"

  $repository_remote_url = "https://github.com/anthill-platform/anthill-message.git"
  $source_directory = "${anthill::sources_location}/${service_name}"

  $db_location = "mysql-${hostname}"
  $db_name = "${environment}_${service_name}"

  $token_cache_location = "redis-${hostname}"
  $token_cache_max_connections = $anthill::redis_default_max_connections
  $token_cache_db = 4

  $rate_cache_location = "redis-${hostname}"
  $rate_cache_max_connections = $anthill::redis_default_max_connections
  $rate_cache_db = 2
  $rate_read_messages_with = "15,20"

  $enable_monitoring = $anthill::services_enable_monitoring
  $monitoring_location = $anthill::services_monitoring_location

  $internal_broker_location = "rabbitmq-${hostname}"
  $pubsub_location = "rabbitmq-${hostname}"
  $message_broker_location = "rabbitmq-${hostname}"
  $message_broker_max_connections = 1

  $nginx_max_body_size = '1024m'
}