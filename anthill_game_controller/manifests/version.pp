define anthill_game_controller::version (

  $version = $title,
  $source_commit,

  $source_directory = $anthill_game_controller::source_directory,
  $sock_path = $anthill_game_controller::sock_path,
  $binaries_path = $anthill_game_controller::binaries_path,
  $ports_pool_from = $anthill_game_controller::ports_pool_from,
  $ports_pool_to = $anthill_game_controller::ports_pool_to,
  $gs_host = $anthill_game_controller::gs_host,

  $service_directory_name = $anthill_game_controller::service_directory_name,

  $host = $anthill_game_controller::host,
  $domain = $anthill_game_controller::domain,

  $token_cache_host = $anthill_game_controller::token_cache_host,
  $token_cache_port = $anthill_game_controller::token_cache_port,
  $token_cache_max_connections = $anthill_game_controller::token_cache_max_connections,
  $token_cache_db = $anthill_game_controller::token_cache_db,

  $internal_broker = $anthill_game_controller::internal_broker,
  $internal_restrict = $anthill_game_controller::internal_restrict,
  $internal_max_connections = $anthill_game_controller::internal_max_connections,

  $pubsub = $anthill_game_controller::pubsub,

  $discovery_service = $anthill_game_controller::discovery_service,
  $auth_key_public = $anthill_game_controller::auth_key_public,

  $application_arguments = '',
  $instances = undef,
  $ensure = undef,
  $use_nginx = undef,
  $use_supervisor = undef,
  $runtime_location = undef,
  $sockets_location = undef
) {

  if ! defined(Anthill_game_controller::Version[$version]) {
    fail("anthill_game:version { \"${version}\": } is not defined. Please define it with appropriate commit")
  }

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

  anthill::service::version { "${anthill_game_controller::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_game_controller::service_name,
    service_directory_name                      => $service_directory_name,
    args                                        => $args,

    source_directory                            => $source_directory,
    source_commit                               => $source_commit,

    host                                        => $host,
    domain                                      => $domain,
    ensure                                      => $ensure,

    internal_broker                             => $internal_broker,
    internal_restrict                           => $internal_restrict,
    internal_max_connections                    => $internal_max_connections,

    pubsub                                      => $pubsub,
    discovery_service                           => $discovery_service,
    auth_key_public                             => $auth_key_public,

    instances                                   => $instances,
    use_nginx                                   => $use_nginx,
    use_supervisor                              => $use_supervisor,
    runtime_location                            => $runtime_location,
    sockets_location                            => $sockets_location,
    application_arguments                       => $application_arguments,
    application_environment                     => $application_environment,

    require                                     => Anthill::Common::Version[$version]

  }
}