define anthill_message::version (

  String $source_commit,
  String $version                                     = $title,

  String $source_directory                            = $anthill_message::source_directory,

  String $db_location                                 = $anthill_message::db_location,
  String $db_name                                     = $anthill_message::db_name,

  String $token_cache_location                        = $anthill_message::token_cache_location,
  Integer $token_cache_max_connections                = $anthill_message::token_cache_max_connections,
  Integer $token_cache_db                             = $anthill_message::token_cache_db,

  Optional[String] $host                              = $anthill_message::host,
  Optional[String] $domain                            = $anthill_message::domain,

  String $internal_broker_location                    = $anthill_message::internal_broker_location,
  Optional[Array[String]] $internal_restrict          = $anthill_message::internal_restrict,
  Optional[Integer] $internal_max_connections         = $anthill_message::internal_max_connections,

  String $pubsub_location                             = $anthill_message::pubsub_location,
  Optional[String] $discovery_service                 = $anthill_message::discovery_service,
  Optional[String] $auth_key_public                   = $anthill_message::auth_key_public,

  String $message_broker_location                     = $anthill_message::message_broker_location,
  Integer $message_broker_max_connections             = $anthill_message::message_broker_max_connections,

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
  anthill::ensure_location("message broker", $message_broker_location)

  $internal_broker = generate_rabbitmq_url(Anthill::Location[$internal_broker_location], $environment)
  $pubsub = generate_rabbitmq_url(Anthill::Location[$pubsub_location], $environment)
  $message_broker = generate_rabbitmq_url(Anthill::Location[$message_broker_location], $environment)

  $args = {
    "db_host" => getparam(Anthill::Location[$db_location], "host"),
    "db_username" => getparam(Anthill::Location[$db_location], "username"),
    "db_name" => $db_name,
    "token_cache_host" => getparam(Anthill::Location[$token_cache_location], "host"),
    "token_cache_port" => getparam(Anthill::Location[$token_cache_location], "port"),
    "token_cache_max_connections" => $token_cache_max_connections,
    "token_cache_db" => $token_cache_db,

    "message_broker" => $message_broker,
    "message_broker_max_connections" => $message_broker_max_connections
  }

  $application_environment = {
    "db_password" => getparam(Anthill::Location[$db_location], "password")
  }

  anthill::service::version { "${anthill_message::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_message::service_name,
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