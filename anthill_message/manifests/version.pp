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

  String $rate_cache_location                         = $anthill_message::rate_cache_location,
  Integer $rate_cache_max_connections                 = $anthill_message::rate_cache_max_connections,
  Integer $rate_cache_db                              = $anthill_message::rate_cache_db,
  String $rate_read_messages_with                     = $anthill_message::rate_read_messages_with,

  Boolean $enable_monitoring                          = $anthill_message::enable_monitoring,
  String $monitoring_location                         = $anthill_message::monitoring_location,

  Boolean $debug                                      = $anthill_message::debug,

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

  $db = anthill::ensure_location("mysql database", $db_location, true)
  $token_cache = anthill::ensure_location("token cache redis", $token_cache_location, true)
  $rate_cache = anthill::ensure_location("ratelimit cache redis", $rate_cache_location, true)
  $internal_broker = generate_rabbitmq_url(anthill::ensure_location("internal broker", $internal_broker_location, true), $environment)
  $pubsub = generate_rabbitmq_url(anthill::ensure_location("pubsub", $pubsub_location, true), $environment)
  $message_broker = generate_rabbitmq_url(anthill::ensure_location("message broker", $message_broker_location, true), $environment)

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
    "rate_read_messages_with" => $rate_read_messages_with,

    "message_broker" => $message_broker,
    "message_broker_max_connections" => $message_broker_max_connections
  }

  $application_environment = {
    "db_password" => $db["password"]
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