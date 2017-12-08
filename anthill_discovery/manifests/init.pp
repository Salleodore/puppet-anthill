
class anthill_discovery (

  $default_version = undef,
  $service_name = $anthill_discovery::params::service_name,

  $repository_remote_url = $anthill_discovery::params::repository_remote_url,
  $source_directory = $anthill_discovery::params::source_directory,

  $services_init_file = $anthill_discovery::params::services_init_file,

  $discover_services_host = $anthill_discovery::params::discover_services_host,
  $discover_services_port = $anthill_discovery::params::discover_services_port,
  $discover_services_db = $anthill_discovery::params::discover_services_db,
  $discover_services_max_connections = $anthill_discovery::params::discover_services_max_connections,

  $token_cache_host = $anthill_discovery::params::token_cache_host,
  $token_cache_port = $anthill_discovery::params::token_cache_port,
  $token_cache_db = $anthill_discovery::params::token_cache_db,
  $token_cache_max_connections = $anthill_discovery::params::token_cache_max_connections,

  $ensure = undef,

  $host = undef,
  $domain = undef,
  $listen_port = undef,
  $ssl = undef,
  $ssl_port = undef,
  $ssl_cert = undef,
  $ssl_key = undef,
  $external_domain_name = undef,
  $internal_domain_name = undef,

  $use_supervisor = undef,
  $use_nginx = undef,
  $use_mysql = false,
  $use_redis = undef,
  $internal_broker = undef,
  $pubsub = undef,
  $internal_restrict = undef,
  $internal_max_connections = undef,
  $discovery_service = undef,
  $auth_key_public = undef,
  $whitelist = undef
) inherits anthill_discovery::params {

  require anthill::common

  concat { $services_init_file:
    ensure => $ensure,
    owner  => $anthill::applications_user,
    group  => $anthill::applications_group,
    mode   => '0440',
    require => File[$anthill::runtime_location]
  }

  concat::fragment { "${anthill::runtime_location}/discovery-services-header":
    target => $services_init_file,
    content => template("anthill_discovery/services_init_header.erb"),
    order => "0"
  }

  concat::fragment { "${anthill::runtime_location}/discovery-services-footer":
    target => $services_init_file,
    content => template("anthill_discovery/services_init_footer.erb"),
    order => "9"
  }

  Anthill::Discovery::Entry <<| |>>

  anthill::service {$service_name:

    default_version => $default_version,
    repository_remote_url => $repository_remote_url,
    repository_source_directory => $source_directory,

    service_name => $service_name,
    ensure => $ensure,

    use_nginx => $use_nginx,
    use_mysql => $use_mysql,

    domain => $domain,
    listen_port => $listen_port,
    ssl => $ssl,
    ssl_port => $ssl_port,
    ssl_cert => $ssl_cert,
    ssl_key => $ssl_key,

    external_domain_name => $external_domain_name,
    internal_domain_name => $internal_domain_name,
    internal_broker => $internal_broker,

    whitelist => $whitelist,
    dns_first_record => true
  }

}
