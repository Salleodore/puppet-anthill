define anthill_game::controller::version (

  $version,
  $default_version = undef,

  $sock_path = $anthill_game::controller::sock_path,
  $binaries_path = $anthill_game::controller::binaries_path,
  $ports_pool_from = $anthill_game::controller::ports_pool_from,
  $ports_pool_to = $anthill_game::controller::ports_pool_to,
  $gs_host = $anthill_game::controller::gs_host,

  $service_directory_name = $anthill_game::controller::service_directory_name,

  $host = $anthill_game::controller::host,
  $domain = $anthill_game::controller::domain,

  $token_cache_host = $anthill_game::controller::token_cache_host,
  $token_cache_port = $anthill_game::controller::token_cache_port,
  $token_cache_max_connections = $anthill_game::controller::token_cache_max_connections,
  $token_cache_db = $anthill_game::controller::token_cache_db,

  $internal_broker = $anthill_game::controller::internal_broker,
  $internal_restrict = $anthill_game::controller::internal_restrict,
  $internal_max_connections = $anthill_game::controller::internal_max_connections,

  $pubsub = $anthill_game::controller::pubsub,

  $discovery_service = $anthill_game::controller::discovery_service,
  $auth_key_public = $anthill_game::controller::auth_key_public,

  $application_arguments = '',
  $instances = undef,
  $ensure = undef,
  $use_nginx = undef,
  $use_supervisor = undef,
  $applications_location = undef,
  $sockets_location = undef,
  $ensure_service_directory = false,

  $whitelist = undef

) {

  $args = {
    "sock_path" => $sock_path,
    "binaries_path" => $binaries_path,
    "ports_pool_from" => $ports_pool_from,
    "ports_pool_to" => $ports_pool_to,
    "gs_host" => $gs_host,

    "token_cache_host" => $token_cache_host,
    "token_cache_port" => $token_cache_port,
    "token_cache_max_connections" => $token_cache_max_connections,
    "token_cache_db" => $token_cache_db
  }

  $application_environment = {
  }

  anthill::service::version { "${name}":
    version                                     => $version,
    default_version                             => $default_version,
    service_name                                => $anthill_game::controller::service_name,
    service_directory_name                      => $service_directory_name,
    args                                        => $args,
    subdirectory                                => 'src/controller',
    ensure_service_directory                    => $ensure_service_directory,

    host                                        => $host,
    domain                                      => $domain,

    internal_broker                             => $internal_broker,
    internal_restrict                           => $internal_restrict,
    internal_max_connections                    => $internal_max_connections,

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