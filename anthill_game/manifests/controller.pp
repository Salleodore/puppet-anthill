
class anthill_game::controller (

  $service_name = $anthill_game::controller::params::service_name,

  $sock_path = $anthill_game::controller::params::sock_path,
  $binaries_path = $anthill_game::controller::params::binaries_path,
  $ports_pool_from = $anthill_game::controller::params::ports_pool_from,
  $ports_pool_to = $anthill_game::controller::params::ports_pool_to,
  $gs_host = $anthill_game::controller::params::gs_host,

  $service_directory_name = $anthill_game::controller::params::service_directory_name,
  $nginx_max_body_size = $anthill_game::controller::params::nginx_max_body_size,

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
  $use_redis = undef,
  $internal_broker = undef,
  $pubsub = undef,
  $internal_restrict = undef,
  $internal_max_connections = undef,
  $discovery_service = undef,
  $auth_key_public = undef

) inherits anthill_game::controller::params {

  file { $binaries_path:
    ensure => 'directory',
    owner  => $anthill::applications_user,
    group  => $anthill::applications_group,
    mode   => '0760'
  }

  anthill::service { $service_name:
    service_name => $service_name,
    ensure => $ensure,

    use_nginx => $use_nginx,
    use_mysql => false,

    nginx_max_body_size => $nginx_max_body_size,

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
