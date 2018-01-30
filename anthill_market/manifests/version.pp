define anthill_market::version (

  String $source_commit,
  String $version                                     = $title,

  String $source_directory                            = $anthill_market::source_directory,

  String $db_location                                 = $anthill_market::db_location,
  String $db_name                                     = $anthill_market::db_name,

  String $token_cache_location                        = $anthill_market::token_cache_location,
  Integer $token_cache_max_connections                = $anthill_market::token_cache_max_connections,
  Integer $token_cache_db                             = $anthill_market::token_cache_db,

  String $cache_location                              = $anthill_market::cache_location,
  Integer $cache_max_connections                      = $anthill_market::cache_max_connections,
  Integer $cache_db                                   = $anthill_market::cache_db,

  Optional[String] $host                              = $anthill_market::host,
  Optional[String] $domain                            = $anthill_market::domain,

  String $internal_broker_location                    = $anthill_market::internal_broker_location,
  Optional[Array[String]] $internal_restrict          = $anthill_market::internal_restrict,
  Optional[Integer] $internal_max_connections         = $anthill_market::internal_max_connections,

  String $pubsub_location                             = $anthill_market::pubsub_location,
  Optional[String] $discovery_service                 = $anthill_market::discovery_service,
  Optional[String] $auth_key_public                   = $anthill_market::auth_key_public,

  String $application_arguments                       = '',
  Optional[Integer] $instances                        = undef,
  Optional[Enum['present', 'absent']] $ensure         = undef,
  Optional[String] $runtime_location                  = undef,
  Optional[String] $sockets_location                  = undef

) {

  anthill::ensure_location("mysql database", $db_location)
  anthill::ensure_location("token cache redis", $token_cache_location)
  anthill::ensure_location("cache redis", $cache_location)
  anthill::ensure_location("internal broker", $internal_broker_location)
  anthill::ensure_location("pubsub", $pubsub_location)

  $internal_broker = generate_rabbitmq_url(Anthill::Location[$internal_broker_location], $environment)
  $pubsub = generate_rabbitmq_url(Anthill::Location[$pubsub_location], $environment)

  $args = {
    "db_host" => getparam(Anthill::Location[$db_location], "host"),
    "db_username" => getparam(Anthill::Location[$db_location], "username"),
    "db_name" => $db_name,
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
    "db_password" => getparam(Anthill::Location[$db_location], "password")
  }

  anthill::service::version { "${anthill_market::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_market::service_name,
    args                                        => $args,

    source_directory                            => $source_directory,
    source_commit                               => $source_commit,

    host                                        => $host,
    domain                                      => $domain,
    ensure                                      => $ensure,

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