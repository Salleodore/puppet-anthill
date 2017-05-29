define anthill_leaderboard::version (

  $version,
  $default_version = undef,

  $db_host = $anthill_leaderboard::db_host,
  $db_username = $anthill_leaderboard::db_username,
  $db_password = $anthill_leaderboard::db_password,
  $db_name = $anthill_leaderboard::db_name,

  $token_cache_host = $anthill_leaderboard::token_cache_host,
  $token_cache_port = $anthill_leaderboard::token_cache_port,
  $token_cache_max_connections = $anthill_leaderboard::token_cache_max_connections,
  $token_cache_db = $anthill_leaderboard::token_cache_db,

  $host = $anthill_leaderboard::host,
  $domain = $anthill_leaderboard::domain,

  $internal_broker = $anthill_leaderboard::internal_broker,
  $internal_restrict = $anthill_leaderboard::internal_restrict,
  $internal_max_connections = $anthill_leaderboard::internal_max_connections,

  $pubsub = $anthill_leaderboard::pubsub,

  $discovery_service = $anthill_leaderboard::discovery_service,
  $auth_key_public = $anthill_leaderboard::auth_key_public,

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

    "token_cache_host" => $token_cache_host,
    "token_cache_port" => $token_cache_port,
    "token_cache_max_connections" => $token_cache_max_connections,
    "token_cache_db" => $token_cache_db
  }

  $application_environment = {
    "db_password" => $db_password
  }

  anthill::service::version { "${name}":
    version                                     => $version,
    default_version                             => $default_version,
    service_name                                => $anthill_leaderboard::service_name,
    args                                        => $args,

    host                                        => $host,
    internal_broker                             => $internal_broker,
    internal_restrict                           => $internal_restrict,
    internal_max_connections                    => $internal_max_connections,

    mysql_username                              => $anthill::mysql::mysql_username,
    mysql_password                              => $anthill::mysql::mysql_password,

    pubsub                                      => $pubsub,
    domain                                      => $domain,

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