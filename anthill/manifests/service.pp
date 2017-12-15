
define anthill::service (

  String $service_name,
  Optional[String] $default_version               = undef,
  Enum[present, absent] $ensure                   = present,

  Optional[String] $repository_remote_url         = undef,
  Optional[String] $repository_source_directory   = undef,

  String $domain                                  = "${service_name}-${environment}",

  String $external_domain_name                    = $anthill::external_domain_name,
  String $internal_domain_name                    = $anthill::internal_domain_name,
  String $internal_broker_location                = "rabbitmq",

  Boolean $export_discovery_entry                 = true,
  Optional[Array[String]] $whitelist              = undef,
  Boolean $dns_first_record                       = false,

  Boolean $nginx_serve_static                     = true,
  Optional[Integer] $nginx_max_body_size          = undef,
  Hash $nginx_locations                           = {}

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

  include anthill::nginx

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

  anthill::ensure_location("internal broker", $internal_broker_location)

  $internal_broker = generate_rabbitmq_url(Anthill::Location[$internal_broker_location])

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

  if ($export_discovery_entry) {
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
    proxy_http_version => '1.1',

    use_default_location => false,
    index_files          => [],

<<<<<<< HEAD
    client_max_body_size => $nginx_max_body_size
  }
=======
    nginx::resource::location { "nginx_location_${vhost}":
      ensure => $ensure,
      location => "/",
      server => $vhost,
      proxy => "http://\$${environment}_${service_name}",
      ssl => $anthill::nginx::ssl,
      proxy_set_header => $headers,
      proxy_http_version => "1.1",
>>>>>>> 39826f6... Finxed HTTP Version 1.1

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