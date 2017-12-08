
class anthill_static::params {

  $service_name = "static"

  $repository_remote_url = "https://github.com/anthill-platform/anthill-static.git"
  $source_directory = "${anthill::sources_location}/${service_name}"

  # MySQL database
  $db_host = $anthill::mysql::mysql_host
  $db_username = $anthill::mysql::mysql_username
  $db_password = $anthill::mysql::mysql_password
  $db_name = "${environment}_${service_name}"

  # Rate limit cache
  $rate_cache_host = $anthill::redis::host
  $rate_cache_port = $anthill::redis::port
  $rate_cache_max_connections = $anthill::redis_default_max_connections
  $rate_cache_db = 5

  # Regular cache
  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = $anthill::redis_default_max_connections
  $token_cache_db = 4

  # A limit for static upload for user tuple: (amount, time)
  $rate_file_upload = [10, 600]
  # Maximum files size to accept
  $max_file_size = 104857600
}