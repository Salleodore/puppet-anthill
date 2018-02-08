
class anthill_environment (

  String $default_version                       = $anthill::default_version,

  Enum['present', 'absent'] $ensure             = 'present',
  String $service_name                          = $anthill_environment::params::service_name,

  String $repository_remote_url                 = $anthill_environment::params::repository_remote_url,
  String $source_directory                      = $anthill_environment::params::source_directory,

  String $db_location                           = $anthill_environment::params::db_location,
  Boolean $manage_db                            = true,
  String $db_name                               = $anthill_environment::params::db_name,

  String $token_cache_location                  = $anthill_environment::params::token_cache_location,
  Integer $token_cache_db                       = $anthill_environment::params::token_cache_db,
  Integer $token_cache_max_connections          = $anthill_environment::params::token_cache_max_connections,

  Boolean $enable_monitoring                    = $anthill_environment::params::enable_monitoring,
  String $monitoring_location                   = $anthill_environment::params::monitoring_location,

  Boolean $debug                                = $anthill::debug,

  String $internal_broker_location              = $anthill_environment::params::internal_broker_location,
  String $pubsub_location                       = $anthill_environment::params::pubsub_location,

  Optional[String] $discovery_service           = undef,
  Optional[String] $host                        = undef,
  Optional[String] $domain                      = undef,
  Optional[String] $external_domain_name        = undef,
  Optional[String] $internal_domain_name        = undef,

  Optional[Array[String]] $internal_restrict    = undef,
  Optional[Integer] $internal_max_connections   = undef,
  Optional[String] $auth_key_public             = undef,
  Optional[Array[String]] $whitelist            = undef

) inherits anthill_environment::params {

  require anthill::common

  anthill::service {$service_name:
    default_version => $default_version,
    repository_remote_url => $repository_remote_url,
    repository_source_directory => $source_directory,
    service_name => $service_name,
    ensure => $ensure,
    domain => $domain,
    external_domain_name => $external_domain_name,
    internal_domain_name => $internal_domain_name,
    internal_broker_location => $internal_broker_location,
    whitelist => $whitelist
  }

  if ($manage_db)
  {
    @@mysql_database { $db_name:
      ensure => 'present',
      charset => 'utf8',
      tag => [ $db_location ]
    }
  }

}
