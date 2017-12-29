
class anthill::mysql (

  $mysql_host = $anthill::mysql::params::mysql_host,
  $mysql_root_password = $anthill::mysql::params::mysql_root_password,
  $mysql_username = $anthill::mysql::params::mysql_username,
  $mysql_password = $anthill::mysql::params::mysql_password,

  $mysql_package = $anthill::mysql::params::mysql_package

) inherits anthill::mysql::params {

  anchor { 'anthill::mysql::begin': } ->

  class { '::anthill::mysql::install': } ->
  class { '::anthill::mysql::dbuser': } ->

  anchor { 'anthill::mysql::end': }
}