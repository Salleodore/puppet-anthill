define anthill_promo::version (

  String $source_commit,
  String $version                                     = $title,

  String $source_directory                            = $anthill_promo::source_directory,

  String $db_location                                 = $anthill_promo::db_location,
  String $db_name                                     = $anthill_promo::db_name,

  String $token_cache_location                        = $anthill_promo::token_cache_location,
  Integer $token_cache_max_connections                = $anthill_promo::token_cache_max_connections,
  Integer $token_cache_db                             = $anthill_promo::token_cache_db,

  Optional[String] $host                              = $anthill_promo::host,
  Optional[String] $domain                            = $anthill_promo::domain,

  String $internal_broker_location                    = $anthill_promo::internal_broker_location,
  Optional[Array[String]] $internal_restrict          = $anthill_promo::internal_restrict,
  Optional[Integer] $internal_max_connections         = $anthill_promo::internal_max_connections,

  String $rate_cache_location                         = $anthill_promo::rate_cache_location,
  Integer $rate_cache_max_connections                 = $anthill_promo::rate_cache_max_connections,
  Integer $rate_cache_db                              = $anthill_promo::rate_cache_db,
  String $rate_promo_not_found                        = $anthill_promo::rate_promo_not_found,

  Boolean $enable_monitoring                          = $anthill_promo::enable_monitoring,
  String $monitoring_location                         = $anthill_promo::monitoring_location,

  Boolean $debug                                      = $anthill_promo::debug,

  String $pubsub_location                             = $anthill_promo::pubsub_location,
  Optional[String] $discovery_service                 = $anthill_promo::discovery_service,
  Optional[String] $auth_key_public                   = $anthill_promo::auth_key_public,

  String $application_arguments                       = '',
  Optional[Integer] $instances                        = undef,
  Optional[Enum['present', 'absent']] $ensure         = undef,
  Optional[String] $runtime_location                  = undef,
  Optional[String] $sockets_location                  = undef

) {

  $db = anthill::ensure_location("mysql database", $db_location, true)
  $token_cache = anthill::ensure_location("token cache redis", $token_cache_location, true)
  $rate_cache = anthill::ensure_location("ratelimit cache redis", $rate_cache_location, true)
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

    "rate_cache_host" => $rate_cache["host"],
    "rate_cache_port" => $rate_cache["port"],
    "rate_cache_max_connections" => $rate_cache_max_connections,
    "rate_cache_db" => $rate_cache_db,
    "rate_promo_not_found" => $rate_promo_not_found,
  }

  $application_environment = {
    "db_password" => $db["password"]
  }

  anthill::service::version { "${anthill_promo::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_promo::service_name,
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