
class anthill_message::params {

  $service_name = "message"

  $repository_remote_url = "https://github.com/anthill-platform/anthill-message.git"
  $source_directory = "${anthill::sources_location}/${service_name}"

  $db_host = $anthill::mysql::mysql_host
  $db_username = $anthill::mysql::mysql_username
  $db_password = $anthill::mysql::mysql_password
  $db_name = "${environment}_${service_name}"

  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = $anthill::redis_default_max_connections
  $token_cache_db = 4

  $message_broker = "amqp://${anthill::rabbitmq::username}:${anthill::rabbitmq::password}@${anthill::rabbitmq::host}:${anthill::rabbitmq::port}/${environment}"
  $message_broker_max_connections = 10
}