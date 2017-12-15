
define anthill::service (

  $service_name,
  $default_version = undef,
  $ensure = present,

  $repository_remote_url = undef,
  $repository_source_directory = undef,

  $use_nginx = $anthill::manage_nginx,
  $use_mysql = $anthill::manage_mysql,

  $domain = "${service_name}-${environment}",
  $listen_port = $anthill::nginx::listen_port,

  $ssl = $anthill::nginx::ssl,
  $ssl_port = $anthill::nginx::ssl_port,
  $ssl_cert = $anthill::nginx::ssl_cert,
  $ssl_key = $anthill::nginx::ssl_key,

  $mysql_username = $anthill::mysql::mysql_username,
  $mysql_password = $anthill::mysql::mysql_password,

  $external_domain_name = $anthill::external_domain_name,
  $internal_domain_name = $anthill::internal_domain_name,
  $internal_broker = $anthill::rabbitmq::amqp_location,

  $register_discovery_entry = true,

  $whitelist = undef,
  $discover = true,

  $dns_first_record = false,

  $nginx_serve_static = true,
  $nginx_max_body_size = undef,
  $nginx_locations = {}
) {
  $vhost = "${environment}_${service_name}"

  if ($ensure == 'present') {
    if ($repository_source_directory) {
      file { $repository_source_directory:
        ensure => 'directory',
        owner  => $anthill::applications_user,
        group  => $anthill::applications_group,
        mode   => '0760'
      }
    }

    if ($repository_remote_url and $repository_source_directory)
    {
      anthill::source { "${environment}_${service_name}":
        repository_remote_url      => $repository_remote_url,
        repository_local_directory => "${repository_source_directory}/.git"
      }
    }
  } else {
    if ($repository_source_directory) {
      file { $repository_source_directory:
        ensure => 'absent',
        force => true
      }
    }
  }

  if ($use_nginx)
  {
    if (!$anthill::manage_nginx)
    {
      fail("manage_nginx is required to use nginx")
    }

    if ($domain != "")
    {
      $full_domain = "${domain}."
    }
    else
    {
      $full_domain = ""
    }

    $external_location = "${anthill::protocol}://${full_domain}${external_domain_name}"

    # internal network is http-only
    $internal_location = "http://${full_domain}${internal_domain_name}"

    if ($internal_broker) {
      $real_dns_locations = {
        "external" => $external_location,
        "internal" => $internal_location,
        "broker" => $internal_broker
      }
    } else {
      $real_dns_locations = {
        "external" => $external_location,
        "internal" => $internal_location
      }
    }

    if ($register_discovery_entry) {
      @@anthill::discovery::entry { "${environment}_$service_name":
        service_name => $service_name,
        locations    => $real_dns_locations,
        ensure       => $ensure,
        first        => $dns_first_record
      }
    }

    @@anthill::dns::entry { $service_name:
      internal_hostname => "${full_domain}${internal_domain_name}",
      ensure => $ensure,
      tag => "internal"
    }

    if ($default_version) {
      $default_version_map = "${environment}_${service_name}_${default_version}"
      $default_version_require = Anthill::Service::Version["${service_name}_${default_version}"]
    }
    else {
      $default_version_map = undef
      $default_version_require = undef
    }

    nginx::resource::map { "${environment}_${service_name}":
      string => "\$http_x_api_version",
      ensure => $ensure,
      default => $default_version_map,
      include_files => [],
      require => $default_version_require
    }

    nginx::resource::server { $vhost:
      ensure               => $ensure,
      server_name          => [
        "${full_domain}${external_domain_name}",
        "${full_domain}${internal_domain_name}"
      ],
      listen_port          => $anthill::nginx::listen_port,

      ssl                  => $anthill::nginx::ssl,
      ssl_port             => $anthill::nginx::ssl_port,
      ssl_cert             => $anthill::nginx::ssl_cert,
      ssl_key              => $anthill::nginx::ssl_key,

      locations            => $nginx_locations,

      use_default_location => false,
      index_files          => [],

      client_max_body_size => $nginx_max_body_size,
    }

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

    nginx::resource::location { "nginx_location_${vhost}":
      ensure => $ensure,
      location => "/",
      server => $vhost,
      proxy => "http://\$${environment}_${service_name}",
      ssl => $anthill::nginx::ssl,
      proxy_set_header => $headers,
      proxy_http_version => "1.1",

      location_allow => $location_allow,
      location_deny => $location_deny
    }

    if ($nginx_serve_static and $default_version)
    {
      nginx::resource::location { "nginx_location_${vhost}_static":
        ensure => $ensure,
        location => "/static",
        server => $vhost,
        location_alias => "${anthill::sources_location}/${service_name}/${default_version}/static",
        index_files => [],
        ssl => $anthill::nginx::ssl,

        location_allow => $location_allow,
        location_deny => $location_deny
      }
    }

  }

  if ($use_mysql)
  {
    if (!$anthill::manage_mysql)
    {
      fail("manage_mysql is required to use mysql")
    }

    mysql_database { "${environment}_${service_name}":
      ensure => $ensure,
      charset => 'utf8'
    }
  }
}