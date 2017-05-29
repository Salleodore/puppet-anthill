
class anthill_message (

  $service_name = $anthill_message::params::service_name,

  $db_host = $anthill_message::params::db_host,
  $db_username = $anthill_message::params::db_username,
  $db_password = $anthill_message::params::db_password,
  $db_name = $anthill_message::params::db_name,

  $token_cache_host = $anthill_message::params::token_cache_host,
  $token_cache_port = $anthill_message::params::token_cache_port,
  $token_cache_db = $anthill_message::params::token_cache_db,
  $token_cache_max_connections = $anthill_message::params::token_cache_max_connections,

  $message_broker = $anthill_message::params::message_broker,
  $message_broker_max_connections = $anthill_message::params::message_broker_max_connections,

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
  $auth_key_public = undef

) inherits anthill_message::params {

  anthill::service { $service_name:
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
    internal_domain_name => $internal_domain_name
  }

}
