
class anthill_dlc::params {

  $service_name = "dlc"

  $db_host = $anthill::mysql::mysql_host
  $db_username = $anthill::mysql::mysql_username
  $db_password = $anthill::mysql::mysql_password
  $db_name = "${environment}_${service_name}"

  $token_cache_host = $anthill::redis::host
  $token_cache_port = $anthill::redis::port
  $token_cache_max_connections = 500
  $token_cache_db = 12

  $cache_host = $anthill::redis::host
  $cache_port = $anthill::redis::port
  $cache_max_connections = 500
  $cache_db = 13

  $data_location = "${anthill::applications_location}/${environment}-dlc"
  $data_host_location = "${anthill::protocol}://${service_name}-${environment}.${anthill::external_domain_name}/download/"

  $nginx_max_body_size = '1024m'
}