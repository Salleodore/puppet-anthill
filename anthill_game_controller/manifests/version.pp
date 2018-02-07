define anthill_game_controller::version (

  String $source_commit,
  String $version                                     = $title,

  String $source_directory                            = $anthill_game_controller::source_directory,

  String $sock_directory                              = $anthill_game_controller::sock_directory,
  String $binaries_directory                          = $anthill_game_controller::binaries_directory,
  Integer $ports_pool_from                            = $anthill_game_controller::ports_pool_from,
  Integer $ports_pool_to                              = $anthill_game_controller::ports_pool_to,
  String $gs_host                                     = $anthill_game_controller::gs_host,

  String $token_cache_location                        = $anthill_game_controller::token_cache_location,
  Integer $token_cache_max_connections                = $anthill_game_controller::token_cache_max_connections,
  Integer $token_cache_db                             = $anthill_game_controller::token_cache_db,

  String $cache_location                              = $anthill_store::cache_location,
  Integer $cache_max_connections                      = $anthill_store::cache_max_connections,
  Integer $cache_db                                   = $anthill_store::cache_db,

  Boolean $enable_monitoring                          = $anthill_game_controller::enable_monitoring,
  String $monitoring_location                         = $anthill_game_controller::monitoring_location,

  Optional[String] $host                              = $anthill_game_controller::host,
  Optional[String] $domain                            = $anthill_game_controller::domain,

  String $internal_broker_location                    = $anthill_game_controller::internal_broker_location,
  Optional[Array[String]] $internal_restrict          = $anthill_game_controller::internal_restrict,
  Optional[Integer] $internal_max_connections         = $anthill_game_controller::internal_max_connections,

  String $pubsub_location                             = $anthill_game_controller::pubsub_location,
  Optional[String] $discovery_service                 = $anthill_game_controller::discovery_service,
  Optional[String] $auth_key_public                   = $anthill_game_controller::auth_key_public,

  String $application_arguments                       = '',
  Optional[Integer] $instances                        = undef,
  Optional[Enum['present', 'absent']] $ensure         = undef,
  Optional[String] $runtime_location                  = undef,
  Optional[String] $sockets_location                  = undef

) {

  if ! defined(Anthill_game_controller::Version[$version]) {
    fail("anthill_game:version { \"${version}\": } is not defined. Please define it with appropriate commit")
  }

  anthill::ensure_location("token cache redis", $token_cache_location)
  anthill::ensure_location("cache redis", $cache_location)
  anthill::ensure_location("internal broker", $internal_broker_location)
  anthill::ensure_location("pubsub", $pubsub_location)

  $internal_broker = generate_rabbitmq_url(Anthill::Location[$internal_broker_location], $environment)
  $pubsub = generate_rabbitmq_url(Anthill::Location[$pubsub_location], $environment)


  $args = {
    "sock_path" => $sock_directory,
    "binaries_path" => $binaries_directory,
    "ports_pool_from" => $ports_pool_from,
    "ports_pool_to" => $ports_pool_to,
    "gs_host" => $gs_host,

    "token_cache_host" => getparam(Anthill::Location[$token_cache_location], "host"),
    "token_cache_port" => getparam(Anthill::Location[$token_cache_location], "port"),
    "token_cache_max_connections" => $token_cache_max_connections,
    "token_cache_db" => $token_cache_db,

    "cache_host" => getparam(Anthill::Location[$cache_location], "host"),
    "cache_port" => getparam(Anthill::Location[$cache_location], "port"),
    "cache_max_connections" => $cache_max_connections,
    "cache_db" => $cache_db
  }

  $application_environment = {
  }

  anthill::service::version { "${anthill_game_controller::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_game_controller::service_name,
    args                                        => $args,

    source_directory                            => $source_directory,
    source_commit                               => $source_commit,

    host                                        => $host,
    domain                                      => $domain,
    ensure                                      => $ensure,

    enable_monitoring                           => $enable_monitoring,
    monitoring_location                         => $monitoring_location,

    internal_broker                             => $internal_broker,
    internal_restrict                           => $internal_restrict,
    internal_max_connections                    => $internal_max_connections,

    pubsub                                      => $pubsub,
    discovery_service                           => $discovery_service,
    auth_key_public                             => $auth_key_public,

    instances                                   => $instances,
    runtime_location                            => $runtime_location,
    sockets_location                            => $sockets_location,
    application_arguments                       => $application_arguments,
    application_environment                     => $application_environment,

    require                                     => Anthill::Common::Version[$version]

  }
}