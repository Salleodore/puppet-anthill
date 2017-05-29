define anthill_environment::version (

  $version,
  $default_version = true,
  $api_versions = $anthill_environment::api_versions,

  $db_host = $anthill_environment::db_host,
  $db_username = $anthill_environment::db_username,
  $db_password = $anthill_environment::db_password,
  $db_name = $anthill_environment::db_name,

  $token_cache_host = $anthill_environment::token_cache_host,
  $token_cache_port = $anthill_environment::token_cache_port,
  $token_cache_max_connections = $anthill_environment::token_cache_max_connections,
  $token_cache_db = $anthill_environment::token_cache_db,

  $host = $anthill_environment::host,
  $domain = $anthill_environment::domain,

  $internal_broker = $anthill_environment::internal_broker,
  $internal_restrict = $anthill_environment::internal_restrict,
  $internal_max_connections = $anthill_environment::internal_max_connections,

  $pubsub = $anthill_environment::pubsub,

  $discovery_service = $anthill_environment::discovery_service,
  $auth_key_public = $anthill_environment::auth_key_public,

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
    "api_versions" => join($api_versions, ","),

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
    service_name                                => $anthill_environment::service_name,
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