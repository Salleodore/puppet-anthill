
define anthill::service::version (

  $service_name,
  $version,
  $args,

  $source_directory = "${anthill::sources_location}/${service_name}",
  $source_commit,

  $host = undef,
  $domain = undef,

  $application_arguments = '',
  $application_environment = {},
  $service_directory_name = $service_name,
  $subdirectory = 'src',
  $instances = 1,
  $ensure = present,

  $debug = $anthill::debug,

  $use_nginx = $anthill::manage_nginx,
  $use_supervisor = $anthill::manage_supervisor,
  $use_redis = $anthill::manage_redis,
  $logging_level = $anthill::logging_level,

  $internal_broker = "amqp://${anthill::rabbitmq::username}:${anthill::rabbitmq::password}@${anthill::rabbitmq::host}:${anthill::rabbitmq::port}/${environment}",
  $pubsub = "amqp://${anthill::rabbitmq::username}:${anthill::rabbitmq::password}@${anthill::rabbitmq::host}:${anthill::rabbitmq::port}/${environment}",

  $internal_restrict = ["127.0.0.1/24", "192.168.0.0/16", "::1/128"],
  $internal_max_connections = '10',

  $mysql_username = $anthill::mysql::mysql_username,
  $mysql_password = $anthill::mysql::mysql_password,

  $discovery_service = "http://discovery-${environment}.${anthill::internal_domain_name}",
  $auth_key_public = "${anthill::keys::application_keys_location}/${environment}/${anthill::keys::application_keys_public_name}",

  $runtime_location = $anthill::runtime_location,
  $sockets_location = $anthill::sockets_location,

  $user = $anthill::supervisor::user,
  $nginx_serve_static = true

) {

  if ($host) and ($domain) {
    fail("either host or domain should be defined.")
  }

  if (!$source_directory) {
    fail("source_directory is not defined")
  }

  if (!$source_commit) {
    fail("source_commit is not defined")
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
  $service_version_sock = "${service_name}.${version}"
  $service_directory = "${source_directory}/${version}"

  anthill::checkout_version { "${environment}_${service_name}":
    ensure => $ensure,
    version_directory => $service_directory,
    source_directory => "${source_directory}/.git",
    directory_name => $service_name,
    source_commit => $source_commit,
    notify => Supervisor::Program["${environment}_${service_name}_${version}"]
  }

  if ($use_nginx) {
    $vhost = "${environment}_${service_name}"

    $sockets = range(1, $instances).map |$index| {
      "unix:${sockets_location}/${environment}.${service_name}.${version}.${index}.sock"
    }

    nginx::resource::upstream { "${environment}_${service_name}_${version}":
      members => $sockets,
      ensure  => $ensure
    }

    if ($ensure == 'present') {
      nginx::resource::map::entry { "nginx_map_entry_${environment}_${service_name}_${version}":
        map   => "${environment}_${service_name}",
        key   => $version,
        value => "${environment}_${service_name}_${version}"
      }
    }

  }

  if ($use_supervisor)
  {

    $listen_socket = "unix:${sockets_location}/${environment}.${service_version_sock}.%(process_num)s.sock"

    if ($nginx_serve_static) {
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
      "logging" => $logging_level,
      "api_version" => $version
    }, $args)

    $common_lib_source_directory = getparam(Anthill::Common::Version[$version], 'source_directory')
    $common_lib_source_directory_w_version = "${common_lib_source_directory}/${version}"

    $result_environment = merge({
      "PYTHONPATH" => "${common_lib_source_directory_w_version}/src",
      "auth_key_public" => $auth_key_public
    }, $application_environment)


    $base_arguments = convert_cmd_args($result_arguments)
    $env = convert_environment_args($result_environment)

    $command = "${anthill::virtualenv_location}/${environment}/bin/python ${service_directory}/${subdirectory}/server.py $base_arguments $application_arguments"

    supervisor::program { "${environment}_${service_name}_${version}":
      ensure               => $ensure,
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
      require => [Anthill::Checkout_version["${environment}_${service_name}"], File[$service_directory]]
    }

    if ($ensure == present) {
      if ($source_directory and $source_commit) {
        Exec["checkout_version_${service_directory}"] ~>
        Supervisor::Program["${environment}_${service_name}_${version}"]
      }
    }
  }

}