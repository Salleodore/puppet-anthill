
class anthill::rabbitmq (

  $username = $anthill::rabbitmq::params::username,
  $password = $anthill::rabbitmq::params::password,
  $host = $anthill::rabbitmq::params::host,
  $port = $anthill::rabbitmq::params::port,

  $admin_management = $anthill::rabbitmq::params::admin_management,
  $admin_port = $anthill::rabbitmq::params::admin_port,
  $admin_username = $anthill::rabbitmq::params::admin_username,
  $admin_password = $anthill::rabbitmq::params::admin_password,

  $amqp_location = "amqp://${username}:${password}@rabbitmq-${environment}.${anthill::internal_domain_name}:${port}/${environment}"

) inherits anthill::rabbitmq::params {

  anchor { 'anthill::rabbitmq::begin': } ->

  class { '::anthill::rabbitmq::install': } ->

  anchor { 'anthill::rabbitmq::end': }
}