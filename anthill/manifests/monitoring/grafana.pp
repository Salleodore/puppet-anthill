
class anthill::monitoring::grafana (

  Enum[present, absent] $ensure             = present,

  Boolean $export_location                  = true,
  String $export_location_name              = "grafana-${hostname}",

  String $listen_host                       = $anthill::monitoring::grafana::params::listen_host,
  Integer $listen_port                      = $anthill::monitoring::grafana::params::listen_port,

  String $admin_username                    = $anthill::monitoring::grafana::params::admin_username,
  String $admin_password                    = $anthill::monitoring::grafana::params::admin_password,

  $manage_mysql_db = $anthill::monitoring::grafana::params::manage_mysql_db,
  $manage_mysql_user = $anthill::monitoring::grafana::params::manage_mysql_user,

  $mysql_backend_location = $anthill::monitoring::grafana::params::mysql_backend_location,
  $mysql_backend_username = $anthill::monitoring::grafana::params::mysql_backend_username,
  $mysql_backend_password = $anthill::monitoring::grafana::params::mysql_backend_password,
  $mysql_backend_db = $anthill::monitoring::grafana::params::mysql_backend_db,

  $redis_backend_location = $anthill::monitoring::grafana::params::redis_backend_location,

) inherits anthill::monitoring::grafana::params {

  anchor { 'anthill::monitoring::grafana::begin': } ->

  class { '::anthill::monitoring::grafana::install': } ->
  class { '::anthill::monitoring::grafana::nginx': } ->
  class { '::anthill::monitoring::grafana::location': } ->

  anchor { 'anthill::monitoring::grafana::end': }

}