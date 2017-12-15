
class anthill::monitoring::influxdb (
  Enum[present, absent] $ensure             = present,

  Boolean $export_location                  = true,
  String $export_location_name              = "influxdb-${hostname}",

  String $http_listen_host                  = $anthill::monitoring::influxdb::params::http_listen_host,
  Integer $http_listen_port                 = $anthill::monitoring::influxdb::params::http_listen_port,

  String $database_name                    = $anthill::monitoring::influxdb::params::database_name,

  String $admin_username                    = $anthill::monitoring::influxdb::params::admin_username,
  String $admin_password                    = $anthill::monitoring::influxdb::params::admin_password,

  Boolean $export_grafana_datasource        = true,
  String $grafana_location                  = $anthill::monitoring::influxdb::params::grafana_location,

  String $application_username              = $anthill::monitoring::influxdb::params::application_username,
  String $application_password              = $anthill::monitoring::influxdb::params::application_password,

  Boolean $listen_collectd                  = $anthill::monitoring::influxdb::params::listen_collectd,
  String $collectd_listen_host              = $anthill::monitoring::influxdb::params::collectd_listen_host,
  Integer $collectd_listen_port             = $anthill::monitoring::influxdb::params::collectd_listen_port,

  Boolean $collectd_types_ensure            = $anthill::monitoring::influxdb::params::collectd_types_ensure,
  String $collectd_types_location           = $anthill::monitoring::influxdb::params::collectd_types_location,

) inherits anthill::monitoring::influxdb::params {

  anchor { 'anthill::monitoring::influxdb::begin': } ->

  class { '::anthill::monitoring::influxdb::install': } ->
  class { '::anthill::monitoring::influxdb::db': } ->
  class { '::anthill::monitoring::influxdb::location': } ->
  class { '::anthill::monitoring::influxdb::datasource': } ->

  anchor { 'anthill::monitoring::influxdb::end': }

}