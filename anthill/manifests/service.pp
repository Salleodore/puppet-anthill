
define anthill::service (

  $service_name,
  $ensure = 'present',

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

  $nginx_max_body_size = undef,
  $nginx_locations = {}
) {

  $vhost = "${environment}_${service_name}"

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

    nginx::resource::vhost { "${vhost}":
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

      add_header => {
        "Access-Control-Allow-Origin" => "*' 'always"
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
      ensure => 'present',
      charset => 'utf8'
    }
  }
}