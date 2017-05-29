define anthill_message::version (

  $version,
  $default_version = undef,

  $db_host = $anthill_message::db_host,
  $db_username = $anthill_message::db_username,
  $db_password = $anthill_message::db_password,
  $db_name = $anthill_message::db_name,

  $token_cache_host = $anthill_message::token_cache_host,
  $token_cache_port = $anthill_message::token_cache_port,
  $token_cache_max_connections = $anthill_message::token_cache_max_connections,
  $token_cache_db = $anthill_message::token_cache_db,

  $message_broker = $anthill_message::message_broker,
  $message_broker_max_connections = $anthill_message::message_broker_max_connections,

  $host = $anthill_message::host,
  $domain = $anthill_message::domain,

  $internal_broker = $anthill_message::internal_broker,
  $internal_restrict = $anthill_message::internal_restrict,
  $internal_max_connections = $anthill_message::internal_max_connections,

  $pubsub = $anthill_message::pubsub,

  $discovery_service = $anthill_message::discovery_service,
  $auth_key_public = $anthill_message::auth_key_public,

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

    "message_broker" => $message_broker,
    "message_broker_max_connections" => $message_broker_max_connections
  }

  $application_environment = {
    "db_password" => $db_password
  }

  anthill::service::version { "${name}":
    version                                     => $version,
    default_version                             => $default_version,
    service_name                                => $anthill_message::service_name,
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