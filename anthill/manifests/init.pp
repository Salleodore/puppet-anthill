
class anthill (
  # External domain name, used to give it them to the users (e.g. example.com)
  String $external_domain_name                                        = $anthill::params::external_domain_name,
  # Used for internal commications and DNS resolution, e.g. example.internal
  String $internal_domain_name                                        = $anthill::params::internal_domain_name,
  # Whether export this name as DNS entry or not
  Boolean $export_internal_fqdn                                       = true,
  # Node name in correlation to the Puppet's node, but used for internal communications
  String $internal_fqdn                                               = "${hostname}.${internal_domain_name}",
  # Loggin level for the anthill services
  Enum['info', 'error', 'warning'] $logging_level                     = $anthill::params::logging_level,
  # Debug mode throws debug information to users on exceptions, etc
  Boolean $debug                                                      = $anthill::params::debug,
  # Enable https for services (would require SSL keys)
  Boolean $enable_https                                               = $anthill::params::enable_https,
  # Protocol name for services
  String $protocol                                                    = $enable_https ? { true => 'https', default => 'http'},
  # A directory where Python's virtualenv will rely
  String $virtualenv_location                                         = $anthill::params::virtualenv_location,
  # A directory where UNIX domain sockets will rely
  String $sockets_location                                            = $anthill::params::sockets_location,
  # A directory where the Services directory will rely (see below)
  String $applications_location                                       = $anthill::params::applications_location,
  String $sources_location    = "${applications_location}/${environment}/${anthill::params::sources_location_dir}",
  String $runtime_location    = "${applications_location}/${environment}/${anthill::params::runtime_location_dir}",
  String $tools_location      = "${applications_location}/${environment}/${anthill::params::tools_location_dir}",
  String $keys_location       = "${applications_location}/${environment}/${anthill::params::keys_location_dir}",
  # A username/group in behalf whom the Services will run
  String $applications_user                                           = $anthill::params::applications_user,
  String $applications_group                                          = $anthill::params::applications_group,
  String $applications_user_password                                  = $anthill::params::applications_user_password,
  # Some services may need ssh
  String $ssh_keys_user                                               = $anthill::params::ssh_keys_user,
  String $ssh_keys_group                                              = $anthill::params::ssh_keys_group,
  # How much the services will use the redis connections by default
  Integer $redis_default_max_connections                              = $anthill::params::redis_default_max_connections,
  # A default configuration if the monitoring enabled for all services
  Boolean $services_enable_monitoring                                 = $anthill::params::services_enable_monitoring,
  # Default location of the InfluxDB to push the stats into
  String $services_monitoring_location                                = $anthill::params::services_monitoring_location,

) inherits anthill::params {

  anchor { 'anthill::begin': } ->
  class { '::anthill::install': } ->
  class { '::anthill::node': } ->
  class { '::anthill::git': } ->
  class { '::anthill::python': } ->
  anchor { 'anthill::end': }

}
