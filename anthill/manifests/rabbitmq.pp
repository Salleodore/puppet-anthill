
class anthill::rabbitmq (

  Boolean $export_location                  = true,
  String $export_location_name              = "rabbitmq-${hostname}",

  String $listen_host                       = $anthill::rabbitmq::params::listen_host,
  Integer $listen_port                      = $anthill::rabbitmq::params::listen_port,

  String $username                          = $anthill::rabbitmq::params::username,
  String $password                          = $anthill::rabbitmq::params::password,

  Boolean $admin_management                 = $anthill::rabbitmq::params::admin_management,
  String $admin_listen_host                 = $anthill::rabbitmq::params::admin_listen_host,
  Integer $admin_listen_port                = $anthill::rabbitmq::params::admin_listen_port,
  String $admin_username                    = $anthill::rabbitmq::params::admin_username,
  String $admin_password                    = $anthill::rabbitmq::params::admin_password

) inherits anthill::rabbitmq::params {

  anchor { 'anthill::rabbitmq::begin': } ->

  class { '::anthill::rabbitmq::install': } ->
  class { '::anthill::rabbitmq::location': } ->

  anchor { 'anthill::rabbitmq::end': }
}