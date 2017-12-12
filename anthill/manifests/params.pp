
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

  $sources_location_dir = "sources"
  $runtime_location_dir = "runtime"
  $tools_location_dir = "tools"
  $keys_location_dir = "keys"

  $applications_user = 'anthill'
  # anthill
  $applications_user_password = '$6$4qanSdNuFPMZ4$fLO4Q.XxJ7kjC3BPCeVNAdMmfsCd279VILxkbkMHsRCao4lmlef6tMzUCg9hRCdu3osItXP3E89Gcw.Rqk3uy.'
  $applications_group = 'anthill'

  $ssh_keys_user = 'anthillkeys'
  $ssh_keys_group = 'anthillkeys'

  $redis_default_max_connections = 500
}