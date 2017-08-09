define anthill_game::master::version (

  $version,
  $default_version = undef,

  $deployments_path = $anthill_game::master::deployments_path,

  $db_host = $anthill_game::master::db_host,
  $db_username = $anthill_game::master::db_username,
  $db_password = $anthill_game::master::db_password,
  $db_name = $anthill_game::master::db_name,

  $token_cache_host = $anthill_game::master::token_cache_host,
  $token_cache_port = $anthill_game::master::token_cache_port,
  $token_cache_max_connections = $anthill_game::master::token_cache_max_connections,
  $token_cache_db = $anthill_game::master::token_cache_db,

  $cache_host = $anthill_game::master::cache_host,
  $cache_port = $anthill_game::master::cache_port,
  $cache_max_connections = $anthill_game::master::cache_max_connections,
  $cache_db = $anthill_game::master::cache_db,

  $rate_cache_host = $anthill_game::master::rate_cache_host,
  $rate_cache_port = $anthill_game::master::rate_cache_port,
  $rate_cache_max_connections = $anthill_game::master::rate_cache_max_connections,
  $rate_cache_db = $anthill_game::master::rate_cache_db,

  $party_broker = $anthill_game::master::party_broker,

  $host = $anthill_game::master::host,
  $domain = $anthill_game::master::domain,

  $internal_broker = $anthill_game::master::internal_broker,
  $internal_restrict = $anthill_game::master::internal_restrict,
  $internal_max_connections = $anthill_game::master::internal_max_connections,

  $pubsub = $anthill_game::master::pubsub,

  $discovery_service = $anthill_game::master::discovery_service,
  $auth_key_public = $anthill_game::master::auth_key_public,

  $application_arguments = '',
  $instances = undef,
  $ensure = undef,
  $use_nginx = undef,
  $use_supervisor = undef,
  $applications_location = undef,
  $sockets_location = undef,

  $whitelist = undef

) {

  $args = {
    "db_host" => $db_host,
    "db_username" => $db_username,
    "db_name" => $db_name,

    "deployments_location" => $deployments_path,

    "token_cache_host" => $token_cache_host,
    "token_cache_port" => $token_cache_port,
    "token_cache_max_connections" => $token_cache_max_connections,
    "token_cache_db" => $token_cache_db,

    "cache_host" => $cache_host,
    "cache_port" => $cache_port,
    "cache_max_connections" => $cache_max_connections,
    "cache_db" => $cache_db,

    "rate_cache_host" => $rate_cache_host,
    "rate_cache_port" => $rate_cache_port,
    "rate_cache_max_connections" => $rate_cache_max_connections,
    "rate_cache_db" => $rate_cache_db,

    "party_broker" => $party_broker
  }

  $application_environment = {
    "db_password" => $db_password
  }

  anthill::service::version { "${name}":
    version                                     => $version,
    default_version                             => $default_version,
    service_name                                => $anthill_game::master::service_name,
    args                                        => $args,
    subdirectory                                => 'src/master',

    host                                        => $host,
    domain                                      => $domain,

    internal_broker                             => $internal_broker,
    internal_restrict                           => $internal_restrict,
    internal_max_connections                    => $internal_max_connections,

    mysql_username                              => $anthill::mysql::mysql_username,
    mysql_password                              => $anthill::mysql::mysql_password,

    pubsub                                      => $pubsub,
    discovery_service                           => $discovery_service,
    auth_key_public                             => $auth_key_public,

    instances                                   => $instances,
    use_nginx                                   => $use_nginx,
    use_supervisor                              => $use_supervisor,
    applications_location                       => $applications_location,
    sockets_location                            => $sockets_location,
    application_arguments                       => $application_arguments,
    application_environment                     => $application_environment,

    whitelist                                   => $whitelist

  }
}