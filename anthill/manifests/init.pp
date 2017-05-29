
class anthill (

  $versions,

  $manage_mysql = $anthill::params::manage_mysql,
  $manage_mysql_server = $anthill::params::manage_mysql_server,
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

  $applications_group = $anthill::params::applications_group,

  $applications_user = $anthill::params::applications_user,
  $applications_user_password = $anthill::params::applications_user_password,

  $applications_keys_location = $anthill::params::applications_keys_location,
  $applications_keys_public_key = $anthill::params::applications_keys_public_key,
  $applications_keys_private_key = $anthill::params::applications_keys_private_key,

  $https_keys_location = $anthill::params::https_keys_location,
  $https_keys_certificate = $anthill::params::https_keys_certificate,
  $https_keys_private_key = $anthill::params::https_keys_private_key,

  $virtualenv_location = $anthill::params::virtualenv_location

) inherits anthill::params {

  anchor { 'anthill::begin': } ->
  class { '::anthill::install': } ->
  class { '::anthill::git': } ->
  class { '::anthill::python': } ->
  anchor { 'anthill::end': }

}
