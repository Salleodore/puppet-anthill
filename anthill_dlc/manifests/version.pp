define anthill_dlc::version (

  String $source_commit,
  String $version                                     = $title,

  String $source_directory                            = $anthill_dlc::source_directory,

  String $db_location                                 = $anthill_dlc::db_location,
  String $db_name                                     = $anthill_dlc::db_name,

  String $token_cache_location                        = $anthill_dlc::token_cache_location,
  Integer $token_cache_max_connections                = $anthill_dlc::token_cache_max_connections,
  Integer $token_cache_db                             = $anthill_dlc::token_cache_db,

  String $cache_location                              = $anthill_dlc::cache_location,
  Integer $cache_max_connections                      = $anthill_dlc::cache_max_connections,
  Integer $cache_db                                   = $anthill_dlc::cache_db,

  String $data_location                               = $anthill_dlc::data_location,
  String $data_host_location                          = $anthill_dlc::data_host_location,

  Optional[String] $host                              = $anthill_dlc::host,
  Optional[String] $domain                            = $anthill_dlc::domain,

  String $internal_broker_location                    = $anthill_dlc::internal_broker_location,
  Optional[Array[String]] $internal_restrict          = $anthill_dlc::internal_restrict,
  Optional[Integer] $internal_max_connections         = $anthill_dlc::internal_max_connections,

  String $pubsub_location                             = $anthill_dlc::pubsub_location,
  Optional[String] $discovery_service                 = $anthill_dlc::discovery_service,
  Optional[String] $auth_key_public                   = $anthill_dlc::auth_key_public,

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
    "cache_db" => $cache_db,
    "data_location" => $data_location,
    "data_host_location" => $data_host_location
  }

  $application_environment = {
    "db_password" => getparam(Anthill::Location[$db_location], "password")
  }

  anthill::service::version { "${anthill_dlc::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_dlc::service_name,
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