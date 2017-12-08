define anthill_report::version (

  $version = $title,
  $source_commit,

  $source_directory = $anthill_report::source_directory,

  $db_host = $anthill_report::db_host,
  $db_username = $anthill_report::db_username,
  $db_password = $anthill_report::db_password,
  $db_name = $anthill_report::db_name,

  $token_cache_host = $anthill_report::token_cache_host,
  $token_cache_port = $anthill_report::token_cache_port,
  $token_cache_max_connections = $anthill_report::token_cache_max_connections,
  $token_cache_db = $anthill_report::token_cache_db,

  $rate_cache_host = $anthill_report::rate_cache_host,
  $rate_cache_port = $anthill_report::rate_cache_port,
  $rate_cache_max_connections = $anthill_report::rate_cache_max_connections,
  $rate_cache_db = $anthill_report::rate_cache_db,

  $rate_report_upload = $anthill_report::rate_report_upload,
  $max_report_size = $anthill_report::max_report_size,

  $host = $anthill_report::host,
  $domain = $anthill_report::domain,

  $internal_broker = $anthill_report::internal_broker,
  $internal_restrict = $anthill_report::internal_restrict,
  $internal_max_connections = $anthill_report::internal_max_connections,

  $pubsub = $anthill_report::pubsub,

  $discovery_service = $anthill_report::discovery_service,
  $auth_key_public = $anthill_report::auth_key_public,

  $application_arguments = '',
  $instances = undef,
  $ensure = undef,
  $use_nginx = undef,
  $use_supervisor = undef,
  $runtime_location = undef,
  $sockets_location = undef
) {

  $args = {
    "db_host" => $db_host,
    "db_username" => $db_username,
    "db_name" => $db_name,

    "rate_cache_host" => $rate_cache_host,
    "rate_cache_port" => $rate_cache_port,
    "rate_cache_max_connections" => $rate_cache_max_connections,
    "rate_cache_db" => $rate_cache_db,

    "rate_report_upload" => $rate_report_upload,
    "max_report_size" => $max_report_size,

    "token_cache_host" => $token_cache_host,
    "token_cache_port" => $token_cache_port,
    "token_cache_max_connections" => $token_cache_max_connections,
    "token_cache_db" => $token_cache_db
  }

  $application_environment = {
    "db_password" => $db_password
  }

  anthill::service::version { "${anthill_report::service_name}_${version}":
    version                                     => $version,
    service_name                                => $anthill_report::service_name,
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