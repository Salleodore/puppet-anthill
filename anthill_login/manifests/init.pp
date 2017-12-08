
class anthill_login (

  $default_version = undef,
  $service_name = $anthill_login::params::service_name,

  $repository_remote_url = $anthill_login::params::repository_remote_url,
  $source_directory = $anthill_login::params::source_directory,

  $db_host = $anthill_login::params::db_host,
  $db_username = $anthill_login::params::db_username,
  $db_password = $anthill_login::params::db_password,
  $db_name = $anthill_login::params::db_name,

  $tokens_host = $anthill_login::params::tokens_host,
  $tokens_port = $anthill_login::params::tokens_port,
  $tokens_db = $anthill_login::params::tokens_db,
  $tokens_max_connections = $anthill_login::params::tokens_max_connections,

  $cache_host = $anthill_login::params::cache_host,
  $cache_port = $anthill_login::params::cache_port,
  $cache_db = $anthill_login::params::cache_db,
  $cache_max_connections = $anthill_login::params::cache_max_connections,

  $application_keys_secret = $anthill_login::params::application_keys_secret,
  $auth_key_private = $anthill_login::params::auth_key_private,
  $auth_key_private_passphrase = $anthill_login::params::auth_key_private_passphrase,
  $passwords_salt = $anthill_login::params::passwords_salt,

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
) inherits anthill_login::params {

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
