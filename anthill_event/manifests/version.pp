define anthill_event::version (

  String $source_commit,
  String $version                                     = $title,

  String $source_directory                            = $anthill_event::source_directory,

  String $db_location                                 = $anthill_event::db_location,
  String $db_name                                     = $anthill_event::db_name,

  String $token_cache_location                        = $anthill_event::token_cache_location,
  Integer $token_cache_max_connections                = $anthill_event::token_cache_max_connections,
  Integer $token_cache_db                             = $anthill_event::token_cache_db,

  String $cache_location                              = $anthill_event::cache_location,
  Integer $cache_max_connections                      = $anthill_event::cache_max_connections,
  Integer $cache_db                                   = $anthill_event::cache_db,

  Boolean $enable_monitoring                          = $anthill_event::enable_monitoring,
  String $monitoring_location                         = $anthill_event::monitoring_location,

  Boolean $debug                                      = $anthill_event::debug,

  Optional[String] $host                              = $anthill_event::host,
  Optional[String] $domain                            = $anthill_event::domain,

  String $internal_broker_location                    = $anthill_event::internal_broker_location,
  Optional[Array[String]] $internal_restrict          = $anthill_event::internal_restrict,
  Optional[Integer] $internal_max_connections         = $anthill_event::internal_max_connections,

  String $pubsub_location                             = $anthill_event::pubsub_location,
  Optional[String] $discovery_service                 = $anthill_event::discovery_service,
  Optional[String] $auth_key_public                   = $anthill_event::auth_key_public,

  String $application_arguments                       = '',
  Optional[Integer] $instances                        = undef,
  Optional[Enum['present', 'absent']] $ensure         = undef,
  Optional[String] $runtime_location                  = undef,
  Optional[String] $sockets_location                  = undef

) {

  $db = anthill::ensure_location("mysql database", $db_location, true)
  $token_cache = anthill::ensure_location("token cache redis", $token_cache_location, true)
  $cache = anthill::ensure_location("cache redis", $cache_location, true)
  $internal_broker = generate_rabbitmq_url(anthill::ensure_location("internal broker", $internal_broker_location, true), $environment)
  $pubsub = generate_rabbitmq_url(anthill::ensure_location("pubsub", $pubsub_location, true), $environment)




  $args = {
    "db_host" => $db["host"],
    "db_username" => $db["username"],
    "db_name" => $db_name,
    "token_cache_host" => $token_cache["host"],
    "token_cache_port" => $token_cache["port"],
    "token_cache_max_connections" => $token_cache_max_connections,
    "token_cache_db" => $token_cache_db,
    "cache_host" => $cache["host"],
    "cache_port" => $cache["port"],
    "cache_max_connections" => $cache_max_connections,
    "cache_db" => $cache_db
  }

  $application_environment = {
    "db_password" => $db["password"]
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

    enable_monitoring                           => $enable_monitoring,
    monitoring_location                         => $monitoring_location,
    debug                                       => $debug,

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