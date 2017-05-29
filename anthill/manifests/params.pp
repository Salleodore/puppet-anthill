
class anthill::params {

  $manage_mysql = true
  $manage_redis = true
  $manage_mysql_server = true
  $manage_nginx = true
  $manage_rabbitmq = true
  $manage_supervisor = true

  $debug = false

  $enable_https = false
  $logging_level = 'info'
  $protocol = 'http'

  $external_domain_name = 'anthill.web'
  $internal_domain_name = 'anthill.internal'

  $sockets_location = '/tmp'
  $applications_location = '/opt/anthill'

  $applications_group = 'anthill'

  $applications_user = 'anthill'

  # anthill
  $applications_user_password = '$6$4qanSdNuFPMZ4$fLO4Q.XxJ7kjC3BPCeVNAdMmfsCd279VILxkbkMHsRCao4lmlef6tMzUCg9hRCdu3osItXP3E89Gcw.Rqk3uy.'

  $applications_keys_location = '.anthill-keys'
  $applications_keys_public_key = 'anthill.pub'
  $applications_keys_private_key = 'anthill.pem'

  $https_keys_location = '/opt/.https'
  $https_keys_certificate = undef
  $https_keys_private_key = undef

  $virtualenv_location = '/opt/venv'
}