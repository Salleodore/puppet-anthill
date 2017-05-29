
class anthill_login::params {

  $service_name = "login"

  $db_host = $anthill::mysql::mysql_host
  $db_username = $anthill::mysql::mysql_username
  $db_password = $anthill::mysql::mysql_password
  $db_name = "${environment}_${service_name}"

  $tokens_host = $anthill::redis::host
  $tokens_port = $anthill::redis::port
  $tokens_max_connections = 500
  $tokens_db = 1

  $cache_host = $anthill::redis::host
  $cache_port = $anthill::redis::port
  $cache_max_connections = 500
  $cache_db = 2

  $application_keys_secret = $anthill::keys::application_keys_passphrase
  $passwords_salt = "t6YJbMTvMRnYyPW7WfZC2tGXUsJwy252pU0OiCM5"

  $auth_key_private = "../../${anthill::applications_keys_location}/${anthill::applications_keys_private_key}"
  $auth_key_private_secret = $anthill::keys::private_key_passphrase

}