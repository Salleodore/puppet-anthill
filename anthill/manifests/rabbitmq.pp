
class anthill::rabbitmq (

  Boolean $export_location                  = true,
  String $export_location_name              = "rabbitmq-${hostname}",

  Integer $listen_port                      = $anthill::rabbitmq::params::listen_port,
  String $username                          = $anthill::rabbitmq::params::username,
  String $password                          = $anthill::rabbitmq::params::password,

  Boolean $admin_management                 = $anthill::rabbitmq::params::admin_management,
  Integer $admin_port                       = $anthill::rabbitmq::params::admin_port,
  String $admin_username                    = $anthill::rabbitmq::params::admin_username,
  String $admin_password                    = $anthill::rabbitmq::params::admin_password

) inherits anthill::rabbitmq::params {

  anchor { 'anthill::rabbitmq::begin': } ->

  class { '::anthill::rabbitmq::install': } ->
  class { '::anthill::rabbitmq::location': } ->

  anchor { 'anthill::rabbitmq::end': }
}