
class anthill_event (

  $default_version = undef,
  $service_name = $anthill_event::params::service_name,

  $repository_remote_url = $anthill_event::params::repository_remote_url,
  $source_directory = $anthill_event::params::source_directory,

  $db_host = $anthill_event::params::db_host,
  $db_username = $anthill_event::params::db_username,
  $db_password = $anthill_event::params::db_password,
  $db_name = $anthill_event::params::db_name,

  $token_cache_host = $anthill_event::params::token_cache_host,
  $token_cache_port = $anthill_event::params::token_cache_port,
  $token_cache_db = $anthill_event::params::token_cache_db,
  $token_cache_max_connections = $anthill_event::params::token_cache_max_connections,

  $cache_host = $anthill_event::params::cache_host,
  $cache_port = $anthill_event::params::cache_port,
  $cache_db = $anthill_event::params::cache_db,
  $cache_max_connections = $anthill_event::params::cache_max_connections,

  $schedule_update = $anthill_event::params::schedule_update,

  $ensure = undef,

  $host = undef,
  $domain = undef,
  $listen_port = undef,
  $ssl = undef,
  $ssl_port = undef,
  $ssl_cert = undef,
  $ssl_key = undef,
  $external_domain_name = undef,
  $internal_domain_name = undef,

  $use_supervisor = undef,
  $use_nginx = undef,
  $use_mysql = undef,
  $use_redis = undef,
  $internal_broker = undef,
  $pubsub = undef,
  $internal_restrict = undef,
  $internal_max_connections = undef,
  $discovery_service = undef,
  $auth_key_public = undef,
  $whitelist = undef
) inherits anthill_event::params {

  require anthill::common

  anthill::service {$service_name:

    default_version => $default_version,
    repository_remote_url => $repository_remote_url,
    repository_source_directory => $source_directory,

    service_name => $service_name,
    ensure => $ensure,

    use_nginx => $use_nginx,
    use_mysql => $use_mysql,

    mysql_username => $db_username,
    mysql_password => $db_password,

    domain => $domain,
    listen_port => $listen_port,
    ssl => $ssl,
    ssl_port => $ssl_port,
    ssl_cert => $ssl_cert,
    ssl_key => $ssl_key,

    external_domain_name => $external_domain_name,
    internal_domain_name => $internal_domain_name,
    internal_broker => $internal_broker,

    whitelist => $whitelist
  }

}
