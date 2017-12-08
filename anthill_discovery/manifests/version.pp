define anthill_discovery::version (

  $version = $title,
  $source_commit,

  $source_directory = $anthill_discovery::source_directory,

  $discover_services_host = $anthill_discovery::discover_services_host,
  $discover_services_port = $anthill_discovery::discover_services_port,
  $discover_services_max_connections = $anthill_discovery::discover_services_max_connections,
  $discover_services_db = $anthill_discovery::discover_services_db,

  $token_cache_host = $anthill_discovery::token_cache_host,
  $token_cache_port = $anthill_discovery::token_cache_port,
  $token_cache_max_connections = $anthill_discovery::token_cache_max_connections,
  $token_cache_db = $anthill_discovery::token_cache_db,

  $host = $anthill_discovery::host,
  $domain = $anthill_discovery::domain,

  $internal_broker = $anthill_discovery::internal_broker,
  $internal_restrict = $anthill_discovery::internal_restrict,
  $internal_max_connections = $anthill_discovery::internal_max_connections,

  $pubsub = $anthill_discovery::pubsub,

  $discovery_service = $anthill_discovery::discovery_service,
  $auth_key_public = $anthill_discovery::auth_key_public,

  $application_arguments = '',
  $instances = undef,
  $ensure = undef,
  $use_nginx = undef,
  $use_supervisor = undef,
  $runtime_location = undef,
  $sockets_location = undef
) {

  $args = {
    "discover_services_host" => $discover_services_host,
    "discover_services_port" => $discover_services_port,
    "discover_services_max_connections" => $discover_services_max_connections,
    "discover_services_db" => $discover_services_db,

    "token_cache_host" => $token_cache_host,
    "token_cache_port" => $token_cache_port,
    "token_cache_max_connections" => $token_cache_max_connections,
    "token_cache_db" => $token_cache_db
  }

  anthill::service::version { "${anthill_discovery::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_discovery::service_name,
    args                                        => $args,

    source_directory                            => $source_directory,
    source_commit                               => $source_commit,

    host                                        => $host,
    domain                                      => $domain,
    ensure                                      => $ensure,

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
    runtime_location                            => $runtime_location,
    sockets_location                            => $sockets_location,
    application_arguments                       => $application_arguments,

    require                                     => Anthill::Common::Version[$version]
  }
}