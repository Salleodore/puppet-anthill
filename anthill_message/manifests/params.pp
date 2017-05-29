
class anthill_message::params {

  $service_name = "message"

  $db_host = $anthill::mysql::mysql_host
  $db_username = $anthill::mysql::mysql_username
  $db_password = $anthill::mysql::mysql_password
  $db_name = "${environment}_${service_name}"

  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = 500
  $token_cache_db = 20

  $message_broker = "amqp://${anthill::rabbitmq::username}:${anthill::rabbitmq::password}@${anthill::rabbitmq::host}:${anthill::rabbitmq::port}/${environment}"
  $message_broker_max_connections = 10
}