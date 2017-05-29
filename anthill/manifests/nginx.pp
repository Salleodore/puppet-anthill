
class anthill::nginx (

  $listen_port = $anthill::nginx::params::listen_port,
  $user = $anthill::nginx::params::user,

  $ssl = $anthill::nginx::params::ssl,
  $ssl_cert = $anthill::nginx::params::ssl_cert,
  $ssl_key = $anthill::nginx::params::ssl_key,
  $ssl_port = $anthill::nginx::params::ssl_port

) inherits anthill::nginx::params {

  anchor { 'anthill::nginx::begin': } ->

  class { '::anthill::nginx::install': } ->

  anchor { 'anthill::nginx::end': }
}