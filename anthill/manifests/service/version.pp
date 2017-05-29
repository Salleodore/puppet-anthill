
define anthill::service::version (

  $service_name,
  $version,
  $args,
  $static_with_nginx = true,

  $host = undef,
  $domain = undef,

  $default_version = false,
  $application_arguments = '',
  $application_environment = {},
  $service_directory_name = $service_name,
  $subdirectory = 'src',
  $ensure_service_directory = true,
  $instances = 1,
  $ensure = 'present',

  $debug = $anthill::debug,

  $use_nginx = $anthill::manage_nginx,
  $use_supervisor = $anthill::manage_supervisor,
  $use_redis = $anthill::manage_redis,
  $logging_level = $anthill::logging_level,

  $internal_broker = "amqp://${anthill::rabbitmq::username}:${anthill::rabbitmq::password}@${anthill::rabbitmq::host}:${anthill::rabbitmq::port}/${environment}",
  $pubsub = "amqp://${anthill::rabbitmq::username}:${anthill::rabbitmq::password}@${anthill::rabbitmq::host}:${anthill::rabbitmq::port}/${environment}",

  $internal_restrict = ["127.0.0.1/24", "::1/128"],
  $internal_max_connections = '10',

  $mysql_username = $anthill::mysql::mysql_username,
  $mysql_password = $anthill::mysql::mysql_password,

  $discovery_service = "http://discovery-${environment}.${anthill::internal_domain_name}",
  $auth_key_public = "../../${anthill::applications_keys_location}/${anthill::applications_keys_public_key}",

  $applications_location = $anthill::applications_location,
  $sockets_location = $anthill::sockets_location,

  $user = $anthill::supervisor::user,
  $whitelist = undef

) {

  if ($host) and ($domain) {
    fail("either host or domain should be defined.")
  }

  if ($host != undef) {
    $hostname = $host
  } elsif ($domain != undef) {

    if ($domain != "")
    {
      $full_domain = "${domain}."
    }
    else
    {
      $full_domain = ""
    }

    $hostname = "${anthill::protocol}://${full_domain}${anthill::external_domain_name}"
  } else {
    $hostname = "${anthill::protocol}://${service_name}-${environment}.${anthill::external_domain_name}"
  }

  $service_version = "${service_name}_${version}"
  $service_version_path = "${version}/${service_directory_name}"
  $service_version_sock = "${service_name}.${version}"
  $service_directory = "${applications_location}/${environment}/${service_version_path}"

  if ($use_nginx) {
    $vhost = "${environment}_${service_name}"

    $sockets = range(1, $instances).map |$index| {
      "unix:${sockets_location}/${environment}.${service_name}.${version}.${index}.sock"
    }

    nginx::resource::upstream { "${vhost}_v${version}":
      members => $sockets,
      ensure => $ensure
    }

    $without_dots = regsubst($version, '\\.', '\\.')

    $headers = [
      'Host $host',
      'X-Real-IP $remote_addr',
      'X-Forwarded-For $proxy_add_x_forwarded_for',
      'Proxy ""',
      'Upgrade $http_upgrade',
      'Connection "upgrade"'
    ]

    if ($whitelist) {
      $location_allow = $whitelist
      $location_deny = ['all']
    } else {
      $location_allow = []
      $location_deny = []
    }

    nginx::resource::location { "${vhost}/v${version}":
      ensure => $ensure,
      location => "/v${version}",
      vhost => $vhost,
      rewrite_rules => ["^/v${without_dots}/?(.*) /\$1 break"],
      proxy => "http://${vhost}_v${version}",
      ssl => $anthill::nginx::ssl,
      proxy_set_header => $headers,

      location_allow => $location_allow,
      location_deny => $location_deny
    }

    if ($static_with_nginx)
    {
      nginx::resource::location { "${vhost}/v${version}/static":
        ensure => $ensure,
        location => "/v${version}/static",
        vhost => $vhost,
        location_alias => "$service_directory/static",
        index_files => [],
        ssl => $anthill::nginx::ssl,

        location_allow => $location_allow,
        location_deny => $location_deny
      }
    }

    if ($default_version) {
      nginx::resource::location { "${vhost}/":
        ensure        => $ensure,
        location      => "/",
        vhost         => $vhost,
        rewrite_rules => [],
        proxy         => "http://${vhost}_v${version}",
        ssl => $anthill::nginx::ssl,
        proxy_set_header => $headers,

        location_allow => $location_allow,
        location_deny => $location_deny
      }

      if ($static_with_nginx)
      {
        nginx::resource::location { "${vhost}/static":
          ensure        => $ensure,
          location      => "/static",
          vhost         => $vhost,
          location_alias => "$service_directory/static",
          index_files => [],
          ssl => $anthill::nginx::ssl,

          location_allow => $location_allow,
          location_deny => $location_deny
        }
      }
    }

  }

  if ($use_supervisor)
  {

    $listen_socket = "unix:${sockets_location}/${environment}.${service_version_sock}.%(process_num)s.sock"

    if ($ensure_service_directory) {
      file { "${service_directory}":
        ensure => 'directory',
        owner  => $anthill::applications_user,
        group  => $anthill::applications_group,
        mode   => '0760'
      }
    }

    if ($static_with_nginx) {
      $serve_static = "false"
    } else {
      $serve_static = "true"
    }

    if ($debug) {
      $debug_ = "true"
    } else {
      $debug_ = "false"
    }

    $result_arguments = merge({
      "listen" => $listen_socket,
      "debug" => $debug_,
      "name" => $service_name,
      "host" => $hostname,
      "internal_broker" => $internal_broker,
      "internal_restrict" => $internal_restrict,
      "internal_max_connections" => $internal_max_connections,
      "pubsub" => $pubsub,
      "discovery_service" => $discovery_service,
      "serve_static" => $serve_static,
      "logging" => $logging_level
    }, $args)

    $result_environment = merge({
      "PYTHONPATH" => "../common/src",
      "auth_key_public" => $auth_key_public
    }, $application_environment)


    $base_arguments = convert_cmd_args($result_arguments)
    $env = convert_environment_args($result_environment)

    $command = "/opt/venv/${environment}/bin/python ${service_directory}/${subdirectory}/server.py $base_arguments $application_arguments"

    supervisor::program { "${environment}_${service_version}":
      program_command      => $command,
      program_directory    => "${service_directory}",
      program_process_name => "${environment}_${service_version}_%(process_num)s",
      program_autostart    => true,
      program_numprocs     => $instances,
      program_numprocs_start => 1,
      program_autorestart  => true,
      program_user         => $user,
      program_environment  => $env,
      program_conf_persmissions => '0400',
      program_conf_backup  => false,
      require => File[$service_directory]
    }
  }

}