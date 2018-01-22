define anthill_discovery::version (

  String $source_commit,
  String $version                                     = $title,

  String $source_directory                            = $anthill_discovery::source_directory,
  String $services_init_file                          = $anthill_discovery::services_init_file,

  String $discover_services_location                  = $anthill_discovery::params::discover_services_location,
  Integer $discover_services_max_connections          = $anthill_discovery::discover_services_max_connections,
  Integer $discover_services_db                       = $anthill_discovery::discover_services_db,

  String $token_cache_location                        = $anthill_discovery::token_cache_location,
  Integer $token_cache_max_connections                = $anthill_discovery::token_cache_max_connections,
  Integer $token_cache_db                             = $anthill_discovery::token_cache_db,

  Boolean $enable_monitoring                          = $anthill_discovery::enable_monitoring,
  String $monitoring_location                         = $anthill_discovery::monitoring_location,

  Optional[String] $host                              = $anthill_discovery::host,
  Optional[String] $domain                            = $anthill_discovery::domain,

  String $internal_broker_location                    = $anthill_discovery::internal_broker_location,
  Optional[Array[String]] $internal_restrict          = $anthill_discovery::internal_restrict,
  Optional[Integer] $internal_max_connections         = $anthill_discovery::internal_max_connections,

  String $pubsub_location                             = $anthill_discovery::pubsub_location,
  Optional[String] $auth_key_public                   = $anthill_discovery::auth_key_public,

  String $application_arguments                       = '',
  Optional[Integer] $instances                        = undef,
  Optional[Enum['present', 'absent']] $ensure         = undef,
  Optional[String] $runtime_location                  = undef,
  Optional[String] $sockets_location                  = undef
) {

  anthill::ensure_location("discover services redis", $discover_services_location)
  anthill::ensure_location("token cache redis", $token_cache_location)
  anthill::ensure_location("internal broker", $internal_broker_location)
  anthill::ensure_location("pubsub", $pubsub_location)

  $internal_broker = generate_rabbitmq_url(Anthill::Location[$internal_broker_location], $environment)
  $pubsub = generate_rabbitmq_url(Anthill::Location[$pubsub_location], $environment)

  $args = {
    "discover_services_host" => getparam(Anthill::Location[$discover_services_location], "host"),
    "discover_services_port" => getparam(Anthill::Location[$discover_services_location], "port"),
    "discover_services_max_connections" => $discover_services_max_connections,
    "discover_services_db" => $discover_services_db,

    "token_cache_host" => getparam(Anthill::Location[$token_cache_location], "host"),
    "token_cache_port" => getparam(Anthill::Location[$token_cache_location], "port"),
    "token_cache_max_connections" => $token_cache_max_connections,
    "token_cache_db" => $token_cache_db,

    "services_init_file" => $services_init_file
  }

  anthill::service::version { "${anthill_discovery::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_discovery::service_name,
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
    discovery_service                           => "",
    auth_key_public                             => $auth_key_public,

    instances                                   => $instances,
    runtime_location                            => $runtime_location,
    sockets_location                            => $sockets_location,
    application_arguments                       => $application_arguments,

    require                                     => Anthill::Common::Version[$version]
  }
}