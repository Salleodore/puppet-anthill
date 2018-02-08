
class anthill::monitoring::collectd (

  Enum[present, absent]$ensure                        = present,
  String $influxdb_location                           = $anthill::monitoring::collectd::params::influxdb_location,
  Integer $influxdb_collectd_port                     = $anthill::monitoring::collectd::params::influxdb_collectd_port,

  Boolean $report_memory                              = $anthill::monitoring::collectd::params::report_memory,
  Boolean $report_cpu                                 = $anthill::monitoring::collectd::params::report_cpu,
  Boolean $report_load                                = $anthill::monitoring::collectd::params::report_load,
  Boolean $report_network                             = $anthill::monitoring::collectd::params::report_network,
  Boolean $report_hard_drive                          = $anthill::monitoring::collectd::params::report_hard_drive,
  Boolean $report_mysql                               = $anthill::monitoring::collectd::params::report_mysql,
  Boolean $report_rabbitmq                            = $anthill::monitoring::collectd::params::report_rabbitmq,

  String $report_mysql_db                             = $anthill::monitoring::collectd::params::report_mysql_db,
  String $report_mysql_username                       = $anthill::monitoring::collectd::params::report_mysql_username,
  String $report_mysql_password                       = $anthill::monitoring::collectd::params::report_mysql_password,

  String $custom_types_db                             = $anthill::monitoring::collectd::params::custom_types_db

) inherits anthill::monitoring::collectd::params {

  anchor { 'anthill::monitoring::collectd::begin': } ->
  class { '::anthill::monitoring::collectd::install': } ->
  class { '::anthill::monitoring::collectd::plugins': } ->
  anchor { 'anthill::monitoring::collectd::end': }

}