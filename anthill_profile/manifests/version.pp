define anthill_profile::version (

  $version = $title,
  $source_commit,

  $source_directory = $anthill_profile::source_directory,

  $db_host = $anthill_profile::db_host,
  $db_username = $anthill_profile::db_username,
  $db_password = $anthill_profile::db_password,
  $db_name = $anthill_profile::db_name,

  $token_cache_host = $anthill_profile::token_cache_host,
  $token_cache_port = $anthill_profile::token_cache_port,
  $token_cache_max_connections = $anthill_profile::token_cache_max_connections,
  $token_cache_db = $anthill_profile::token_cache_db,

  $host = $anthill_profile::host,
  $domain = $anthill_profile::domain,

  $internal_broker = $anthill_profile::internal_broker,
  $internal_restrict = $anthill_profile::internal_restrict,
  $internal_max_connections = $anthill_profile::internal_max_connections,

  $pubsub = $anthill_profile::pubsub,

  $discovery_service = $anthill_profile::discovery_service,
  $auth_key_public = $anthill_profile::auth_key_public,

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
    "token_cache_db" => $token_cache_db
  }

  $application_environment = {
    "db_password" => $db_password
  }

  anthill::service::version { "${anthill_profile::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_profile::service_name,
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