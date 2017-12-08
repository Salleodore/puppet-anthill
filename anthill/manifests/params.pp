
class anthill::params {

  $manage_mysql = true
  $manage_redis = true
  $manage_nginx = true
  $manage_rabbitmq = true
  $manage_supervisor = true

  $debug = false

  $enable_https = false
  $logging_level = 'info'
  $protocol = 'http'

  $external_domain_name = 'anthillplatform.org'
  $internal_domain_name = 'anthill.internal'

  $sockets_location = '/tmp'

  $applications_location = '/opt/anthill'
  $virtualenv_location = '/opt/venv'

  $sources_location = "${applications_location}/${environment}/sources"
  $runtime_location = "${applications_location}/${environment}/runtime"
  $tools_location = "${applications_location}/${environment}/tools"
  $keys_location = "${applications_location}/${environment}/keys"

  $applications_user = 'anthill'
  # anthill
  $applications_user_password = '$6$4qanSdNuFPMZ4$fLO4Q.XxJ7kjC3BPCeVNAdMmfsCd279VILxkbkMHsRCao4lmlef6tMzUCg9hRCdu3osItXP3E89Gcw.Rqk3uy.'
  $applications_group = 'anthill'

  $redis_default_max_connections = 500
}