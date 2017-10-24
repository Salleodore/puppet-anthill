define anthill_exec::version (

  $version,
  $default_version = undef,

  $source_path = $anthill_exec::source_path,

  $db_host = $anthill_exec::db_host,
  $db_username = $anthill_exec::db_username,
  $db_password = $anthill_exec::db_password,
  $db_name = $anthill_exec::db_name,

  $token_cache_host = $anthill_exec::token_cache_host,
  $token_cache_port = $anthill_exec::token_cache_port,
  $token_cache_max_connections = $anthill_exec::token_cache_max_connections,
  $token_cache_db = $anthill_exec::token_cache_db,

  $cache_host = $anthill_exec::cache_host,
  $cache_port = $anthill_exec::cache_port,
  $cache_max_connections = $anthill_exec::cache_max_connections,
  $cache_db = $anthill_exec::cache_db,

  $js_call_timeout = $anthill_exec::js_call_timeout,

  $host = $anthill_exec::host,
  $domain = $anthill_exec::domain,

  $internal_broker = $anthill_exec::internal_broker,
  $internal_restrict = $anthill_exec::internal_restrict,
  $internal_max_connections = $anthill_exec::internal_max_connections,

  $pubsub = $anthill_exec::pubsub,

  $discovery_service = $anthill_exec::discovery_service,
  $auth_key_public = $anthill_exec::auth_key_public,

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
    "cache_db" => $cache_db,

    "source_dir" => $source_path,
    "js_call_timeout" => $js_call_timeout
  }

  $application_environment = {
    "db_password" => $db_password
  }

  anthill::service::version { "${name}":
    version                                     => $version,
    default_version                             => $default_version,
    service_name                                => $anthill_exec::service_name,
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