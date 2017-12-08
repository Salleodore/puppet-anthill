define anthill_login::version (

  $version = $title,
  $source_commit,

  $source_directory = $anthill_login::source_directory,

  $db_host = $anthill_login::db_host,
  $db_username = $anthill_login::db_username,
  $db_password = $anthill_login::db_password,
  $db_name = $anthill_login::db_name,

  $tokens_host = $anthill_login::tokens_host,
  $tokens_port = $anthill_login::tokens_port,
  $tokens_max_connections = $anthill_login::tokens_max_connections,
  $tokens_db = $anthill_login::tokens_db,

  $cache_host = $anthill_login::cache_host,
  $cache_port = $anthill_login::cache_port,
  $cache_max_connections = $anthill_login::cache_max_connections,
  $cache_db = $anthill_login::cache_db,

  $application_keys_secret = $anthill_login::application_keys_secret,
  $auth_key_private = $anthill_login::auth_key_private,
  $auth_key_private_passphrase = $anthill_login::auth_key_private_passphrase,

  $host = $anthill_login::host,
  $domain = $anthill_login::domain,

  $internal_broker = $anthill_login::internal_broker,
  $internal_restrict = $anthill_login::internal_restrict,
  $internal_max_connections = $anthill_login::internal_max_connections,

  $pubsub = $anthill_login::pubsub,

  $discovery_service = $anthill_login::discovery_service,
  $auth_key_public = $anthill_login::auth_key_public,
  $passwords_salt = $anthill_login::passwords_salt,

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
    "tokens_host" => $tokens_host,
    "tokens_port" => $tokens_port,
    "tokens_max_connections" => $tokens_max_connections,
    "tokens_db" => $tokens_db,
    "cache_host" => $cache_host,
    "cache_port" => $cache_port,
    "cache_max_connections" => $cache_max_connections,
    "cache_db" => $cache_db
  }

  $application_environment = {
    "db_password" => $db_password,
    "private_key_password" => $auth_key_private_passphrase,
    "application_keys_secret" => $application_keys_secret,
    "auth_key_private" => $auth_key_private,
    "passwords_salt" => $passwords_salt
  }

  anthill::service::version { "${anthill_login::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_login::service_name,
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