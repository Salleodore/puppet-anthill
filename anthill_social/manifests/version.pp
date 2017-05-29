define anthill_social::version (

  $version,
  $default_version = undef,

  $db_host = $anthill_social::db_host,
  $db_username = $anthill_social::db_username,
  $db_password = $anthill_social::db_password,
  $db_name = $anthill_social::db_name,

  $token_cache_host = $anthill_social::token_cache_host,
  $token_cache_port = $anthill_social::token_cache_port,
  $token_cache_max_connections = $anthill_social::token_cache_max_connections,
  $token_cache_db = $anthill_social::token_cache_db,

  $cache_host = $anthill_social::cache_host,
  $cache_port = $anthill_social::cache_port,
  $cache_max_connections = $anthill_social::cache_max_connections,
  $cache_db = $anthill_social::cache_db,

  $host = $anthill_social::host,
  $domain = $anthill_social::domain,

  $internal_broker = $anthill_social::internal_broker,
  $internal_restrict = $anthill_social::internal_restrict,
  $internal_max_connections = $anthill_social::internal_max_connections,

  $pubsub = $anthill_social::pubsub,

  $discovery_service = $anthill_social::discovery_service,
  $auth_key_public = $anthill_social::auth_key_public,

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
    "token_cache_db" => $token_cache_db,

    "cache_host" => $cache_host,
    "cache_port" => $cache_port,
    "cache_max_connections" => $cache_max_connections,
    "cache_db" => $cache_db
  }

  $application_environment = {
    "db_password" => $db_password
  }

  anthill::service::version { "${name}":
    version                                     => $version,
    default_version                             => $default_version,
    service_name                                => $anthill_social::service_name,
    args                                        => $args,

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