define anthill_store::version (

  String $source_commit,
  String $version                                     = $title,

  String $source_directory                            = $anthill_store::source_directory,

  String $db_location                                 = $anthill_store::db_location,
  String $db_name                                     = $anthill_store::db_name,

  String $token_cache_location                        = $anthill_store::token_cache_location,
  Integer $token_cache_max_connections                = $anthill_store::token_cache_max_connections,
  Integer $token_cache_db                             = $anthill_store::token_cache_db,

  Optional[String] $host                              = $anthill_store::host,
  Optional[String] $domain                            = $anthill_store::domain,

  String $internal_broker_location                    = $anthill_store::internal_broker_location,
  Optional[Array[String]] $internal_restrict          = $anthill_store::internal_restrict,
  Optional[Integer] $internal_max_connections         = $anthill_store::internal_max_connections,

  String $pubsub_location                             = $anthill_store::pubsub_location,
  Optional[String] $discovery_service                 = $anthill_store::discovery_service,
  Optional[String] $auth_key_public                   = $anthill_store::auth_key_public,

  String $application_arguments                       = '',
  Optional[Integer] $instances                        = undef,
  Optional[Enum['present', 'absent']] $ensure         = undef,
  Optional[String] $runtime_location                  = undef,
  Optional[String] $sockets_location                  = undef

) {

  anthill::ensure_location("mysql database", $db_location)
  anthill::ensure_location("token cache redis", $token_cache_location)
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
    "token_cache_db" => $token_cache_db
  }

  $application_environment = {
    "db_password" => getparam(Anthill::Location[$db_location], "password")
  }

  anthill::service::version { "${anthill_store::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_store::service_name,
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