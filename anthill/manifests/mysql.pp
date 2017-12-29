
class anthill::mysql (

  Boolean $export_location                  = true,
  String $export_location_name              = "mysql-${hostname}",

  String $listen_port                       = $anthill::mysql::params::listen_port,
  String $root_password                     = $anthill::mysql::params::root_password,
  String $username                          = $anthill::mysql::params::username,
  String $password                          = $anthill::mysql::params::password

  String $mysql_package                     = $anthill::mysql::params::mysql_package

) inherits anthill::mysql::params {

  anchor { 'anthill::mysql::begin': } ->

  class { '::anthill::mysql::install': } ->
  class { '::anthill::mysql::dbuser': } ->
  class { '::anthill::mysql::location': } ->
  class { '::anthill::mysql::databases': } ->

  anchor { 'anthill::mysql::end': }
}