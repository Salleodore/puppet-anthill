
class anthill_static (

  String $default_version                       = $anthill::default_version,

  Enum['present', 'absent'] $ensure             = 'present',
  String $service_name                          = $anthill_static::params::service_name,

  String $repository_remote_url                 = $anthill_static::params::repository_remote_url,
  String $source_directory                      = $anthill_static::params::source_directory,

  String $db_location                           = $anthill_static::params::db_location,
  Boolean $manage_db                            = true,
  String $db_name                               = $anthill_static::params::db_name,

  String $token_cache_location                  = $anthill_static::params::token_cache_location,
  Integer $token_cache_db                       = $anthill_static::params::token_cache_db,
  Integer $token_cache_max_connections          = $anthill_static::params::token_cache_max_connections,

  String $rate_cache_location                   = $anthill_static::params::rate_cache_location,
  Integer $rate_cache_db                        = $anthill_static::params::rate_cache_db,
  Integer $rate_cache_max_connections           = $anthill_static::params::rate_cache_max_connections,

  String $rate_file_upload                      = $anthill_static::params::rate_file_upload,
  Integer $max_file_size                        = $anthill_static::params::max_file_size,

  Boolean $enable_monitoring                    = $anthill_static::params::enable_monitoring,
  String $monitoring_location                   = $anthill_static::params::monitoring_location,

  Boolean $debug                                = $anthill::debug,

  String $internal_broker_location              = $anthill_static::params::internal_broker_location,
  String $pubsub_location                       = $anthill_static::params::pubsub_location,

  Optional[String] $discovery_service           = undef,
  Optional[String] $host                        = undef,
  Optional[String] $domain                      = undef,
  Optional[String] $external_domain_name        = undef,
  Optional[String] $internal_domain_name        = undef,

  Optional[Array[String]] $internal_restrict    = undef,
  Optional[Integer] $internal_max_connections   = undef,
  Optional[String] $auth_key_public             = undef,
  Optional[Array[String]] $whitelist            = undef

) inherits anthill_static::params {

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
