
class anthill::redis (

  $host = $anthill::redis::params::host,
  $port = $anthill::redis::params::port,
  $databases_count = $anthill::redis::params::databases_count

) inherits anthill::redis::params {

  anchor { 'anthill::redis::begin': } ->

  class { '::anthill::redis::install': } ->

  anchor { 'anthill::redis::end': }
}