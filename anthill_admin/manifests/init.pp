
class anthill_admin (

  $service_name = $anthill_admin::params::service_name,

  $token_cache_host = $anthill_admin::params::token_cache_host,
  $token_cache_port = $anthill_admin::params::token_cache_port,
  $token_cache_db = $anthill_admin::params::token_cache_db,
  $token_cache_max_connections = $anthill_admin::params::token_cache_max_connections,

  $cache_host = $anthill_admin::params::cache_host,
  $cache_port = $anthill_admin::params::cache_port,
  $cache_db = $anthill_admin::params::cache_db,
  $cache_max_connections = $anthill_admin::params::cache_max_connections,
  $nginx_max_body_size = $anthill_admin::params::nginx_max_body_size,

  $ensure = undef,

  $listen_port = undef,
  $ssl = undef,
  $ssl_port = undef,
  $ssl_cert = undef,
  $ssl_key = undef,
  $external_domain_name = undef,
  $internal_domain_name = undef,

  $host = undef,
  $domain = undef,
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

) inherits anthill_admin::params {

  anthill::service { $service_name:
    service_name => $service_name,
    ensure => $ensure,

    use_nginx => $use_nginx,
    use_mysql => $use_mysql,

    domain => $domain,
    listen_port => $listen_port,
    ssl => $ssl,
    ssl_port => $ssl_port,
    ssl_cert => $ssl_cert,
    ssl_key => $ssl_key,

    nginx_max_body_size => $nginx_max_body_size,

    external_domain_name => $external_domain_name,
    internal_domain_name => $internal_domain_name
  }

}
