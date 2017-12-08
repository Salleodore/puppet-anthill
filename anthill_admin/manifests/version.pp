define anthill_admin::version (

  $version = $title,
  $source_commit,

  $source_directory = $anthill_admin::source_directory,

  $db_host = $anthill_admin::db_host,
  $db_username = $anthill_admin::db_username,
  $db_password = $anthill_admin::db_password,
  $db_name = $anthill_admin::db_name,

  $token_cache_host = $anthill_admin::token_cache_host,
  $token_cache_port = $anthill_admin::token_cache_port,
  $token_cache_max_connections = $anthill_admin::token_cache_max_connections,
  $token_cache_db = $anthill_admin::token_cache_db,

  $cache_host = $anthill_admin::cache_host,
  $cache_port = $anthill_admin::cache_port,
  $cache_max_connections = $anthill_admin::cache_max_connections,
  $cache_db = $anthill_admin::cache_db,

  $host = $anthill_admin::host,
  $domain = $anthill_admin::domain,

  $internal_broker = $anthill_admin::internal_broker,
  $internal_restrict = $anthill_admin::internal_restrict,
  $internal_max_connections = $anthill_admin::internal_max_connections,

  $pubsub = $anthill_admin::pubsub,

  $discovery_service = $anthill_admin::discovery_service,
  $auth_key_public = $anthill_admin::auth_key_public,

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
    "cache_db" => $cache_db
  }

  $application_environment = {
    "db_password" => $db_password
  }

  anthill::service::version { "${anthill_admin::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_admin::service_name,
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