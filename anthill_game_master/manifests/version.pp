define anthill_game_master::version (

  $version = $title,
  $source_commit,

  $source_directory = $anthill_game_master::source_directory,
  $deployments_path = $anthill_game_master::deployments_path,

  $db_host = $anthill_game_master::db_host,
  $db_username = $anthill_game_master::db_username,
  $db_password = $anthill_game_master::db_password,
  $db_name = $anthill_game_master::db_name,

  $token_cache_host = $anthill_game_master::token_cache_host,
  $token_cache_port = $anthill_game_master::token_cache_port,
  $token_cache_max_connections = $anthill_game_master::token_cache_max_connections,
  $token_cache_db = $anthill_game_master::token_cache_db,

  $cache_host = $anthill_game_master::cache_host,
  $cache_port = $anthill_game_master::cache_port,
  $cache_max_connections = $anthill_game_master::cache_max_connections,
  $cache_db = $anthill_game_master::cache_db,

  $rate_cache_host = $anthill_game_master::rate_cache_host,
  $rate_cache_port = $anthill_game_master::rate_cache_port,
  $rate_cache_max_connections = $anthill_game_master::rate_cache_max_connections,
  $rate_cache_db = $anthill_game_master::rate_cache_db,

  $party_broker = $anthill_game_master::party_broker,

  $host = $anthill_game_master::host,
  $domain = $anthill_game_master::domain,

  $internal_broker = $anthill_game_master::internal_broker,
  $internal_restrict = $anthill_game_master::internal_restrict,
  $internal_max_connections = $anthill_game_master::internal_max_connections,

  $pubsub = $anthill_game_master::pubsub,

  $discovery_service = $anthill_game_master::discovery_service,
  $auth_key_public = $anthill_game_master::auth_key_public,

  $application_arguments = '',
  $instances = undef,
  $ensure = undef,
  $use_nginx = undef,
  $use_supervisor = undef,
  $runtime_location = undef,
  $sockets_location = undef
) {

  if ! defined(Anthill_game_master::Version[$version]) {
    fail("anthill_game:version { \"${version}\": } is not defined. Please define it with appropriate commit")
  }

  $args = {
    "db_host" => $db_host,
    "db_username" => $db_username,
    "db_name" => $db_name,

    "deployments_location" => $deployments_path,

    "token_cache_host" => $token_cache_host,
    "token_cache_port" => $token_cache_port,
    "token_cache_max_connections" => $token_cache_max_connections,
    "token_cache_db" => $token_cache_db,

    "cache_host" => $cache_host,
    "cache_port" => $cache_port,
    "cache_max_connections" => $cache_max_connections,
    "cache_db" => $cache_db,

    "rate_cache_host" => $rate_cache_host,
    "rate_cache_port" => $rate_cache_port,
    "rate_cache_max_connections" => $rate_cache_max_connections,
    "rate_cache_db" => $rate_cache_db,

    "party_broker" => $party_broker
  }

  $application_environment = {
    "db_password" => $db_password
  }

  anthill::service::version { "${anthill_game_master::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_game_master::service_name,
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