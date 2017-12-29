
class anthill::supervisor::params {

  $admin_management = true
  $admin_username = 'admin'
  $admin_password = '1234'

  $domain = undef

  $admin_port = "4545"
  $user = $anthill::applications_user
  $minfds = 64000
}