
class anthill::redis (

  Boolean $export_location                  = true,
  String $export_location_name              = "redis-${hostname}",

  Integer $listen_port                      = $anthill::redis::params::listen_port,
  Integer $databases_count                  = $anthill::redis::params::databases_count

) inherits anthill::redis::params {

  anchor { 'anthill::redis::begin': } ->

  class { '::anthill::redis::install': } ->
  class { '::anthill::redis::location': } ->

  anchor { 'anthill::redis::end': }
}