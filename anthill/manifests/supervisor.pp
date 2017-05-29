
class anthill::supervisor (

  $admin_management = $anthill::supervisor::params::admin_management,
  $admin_port = $anthill::supervisor::params::admin_port,
  $admin_username = $anthill::supervisor::params::admin_username,
  $admin_password = $anthill::supervisor::params::admin_password,
  $user = $anthill::supervisor::params::user,
  $domain = $anthill::supervisor::params::domain

) inherits anthill::supervisor::params {

  anchor { 'anthill::supervisor::begin': } ->

  class { '::anthill::supervisor::install': } ->

  anchor { 'anthill::supervisor::end': }
}