
class anthill (
  $manage_mysql = $anthill::params::manage_mysql,
  $manage_nginx = $anthill::params::manage_nginx,
  $manage_rabbitmq = $anthill::params::manage_rabbitmq,
  $manage_redis = $anthill::params::manage_redis,
  $manage_supervisor = $anthill::params::manage_supervisor,
  $logging_level = $anthill::params::logging_level,

  $debug = $anthill::params::debug,

  $enable_https = $anthill::params::enable_https,
  $protocol = $anthill::params::protocol,

  $external_domain_name = $anthill::params::external_domain_name,
  $internal_domain_name = $anthill::params::internal_domain_name,
  $sockets_location = $anthill::params::sockets_location,
  $applications_location = $anthill::params::applications_location,

  $sources_location = $anthill::params::sources_location,
  $runtime_location = $anthill::params::runtime_location,
  $tools_location = $anthill::params::tools_location,
  $keys_location = $anthill::params::keys_location,

  $applications_user = $anthill::params::applications_user,
  $applications_group = $anthill::params::applications_group,
  $applications_user_password = $anthill::params::applications_user_password,

  $virtualenv_location = $anthill::params::virtualenv_location,
  $redis_default_max_connections = $anthill::params::redis_default_max_connections,

) inherits anthill::params {

  anchor { 'anthill::begin': } ->
  class { '::anthill::install': } ->
  class { '::anthill::git': } ->
  class { '::anthill::python': } ->
  anchor { 'anthill::end': }

}
