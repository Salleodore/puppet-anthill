
class anthill_game_master (

  $default_version = undef,
  $service_name = $anthill_game_master::params::service_name,
  $source_directory = $anthill_game_master::params::source_directory,

  $deployments_path = $anthill_game_master::params::deployments_path,

  $db_host = $anthill_game_master::params::db_host,
  $db_username = $anthill_game_master::params::db_username,
  $db_password = $anthill_game_master::params::db_password,
  $db_name = $anthill_game_master::params::db_name,

  $token_cache_host = $anthill_game_master::params::token_cache_host,
  $token_cache_port = $anthill_game_master::params::token_cache_port,
  $token_cache_db = $anthill_game_master::params::token_cache_db,
  $token_cache_max_connections = $anthill_game_master::params::token_cache_max_connections,

  $cache_host = $anthill_game_master::params::cache_host,
  $cache_port = $anthill_game_master::params::cache_port,
  $cache_db = $anthill_game_master::params::cache_db,
  $cache_max_connections = $anthill_game_master::params::cache_max_connections,

  $rate_cache_host = $anthill_game_master::params::rate_cache_host,
  $rate_cache_port = $anthill_game_master::params::rate_cache_port,
  $rate_cache_db = $anthill_game_master::params::rate_cache_db,
  $rate_cache_max_connections = $anthill_game_master::params::rate_cache_max_connections,

  $party_broker = $anthill_game_master::params::party_broker,

  $nginx_max_body_size = $anthill_game_master::params::nginx_max_body_size,

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
) inherits anthill_game_master::params {

  file { $deployments_path:
    ensure => 'directory',
    owner  => $anthill::applications_user,
    group  => $anthill::applications_group,
    mode   => '0760'
  }

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

    nginx_max_body_size => $nginx_max_body_size,

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
