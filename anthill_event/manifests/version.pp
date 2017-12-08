define anthill_event::version (

  $version = $title,
  $source_commit,

  $source_directory = $anthill_event::source_directory,

  $db_host = $anthill_event::db_host,
  $db_username = $anthill_event::db_username,
  $db_password = $anthill_event::db_password,
  $db_name = $anthill_event::db_name,

  $token_cache_host = $anthill_event::token_cache_host,
  $token_cache_port = $anthill_event::token_cache_port,
  $token_cache_max_connections = $anthill_event::token_cache_max_connections,
  $token_cache_db = $anthill_event::token_cache_db,

  $cache_host = $anthill_event::cache_host,
  $cache_port = $anthill_event::cache_port,
  $cache_max_connections = $anthill_event::cache_max_connections,
  $cache_db = $anthill_event::cache_db,

  $schedule_update = $anthill_event::schedule_update,

  $host = $anthill_event::host,
  $domain = $anthill_event::domain,

  $internal_broker = $anthill_event::internal_broker,
  $internal_restrict = $anthill_event::internal_restrict,
  $internal_max_connections = $anthill_event::internal_max_connections,

  $pubsub = $anthill_event::pubsub,

  $discovery_service = $anthill_event::discovery_service,
  $auth_key_public = $anthill_event::auth_key_public,

  $application_arguments = '',
  $instances = undef,
  $ensure = undef,
  $use_nginx = undef,
  $use_supervisor = undef,
  $runtime_location = undef,
  $sockets_location = undef
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

    "schedule_update" => $schedule_update
  }

  $application_environment = {
    "db_password" => $db_password
  }

  anthill::service::version { "${anthill_event::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_event::service_name,
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
    application_environment                     => $application_environment,

    require                                     => Anthill::Common::Version[$version]

  }
}