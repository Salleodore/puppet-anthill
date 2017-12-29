
class anthill::supervisor::install inherits anthill::supervisor {

  if ($anthill::manage_supervisor)
  {
    class { '::supervisor':
      package => 'latest',
      service => true,

      unix_http_server => false,

      inet_http_server => $admin_management,
      inet_http_server_port => $admin_port,
      inet_http_server_username => $admin_username,
      inet_http_server_password => $admin_password,

      supervisord_minfds => $minfds
    }

    if ($admin_management) {
      if (!$anthill::manage_nginx) {
        fail("Nginx is required to manage supervisor.")
      }

      if ($domain) {
        $domain_id = $domain
      } else {
        $domain_id = "supervisor-${environment}"
      }

      $external_domain_name = $anthill::external_domain_name

      include '::nginx'

      nginx::resource::server { "${environment}_supervisor":
        ensure               => present,
        server_name          => [
          "${domain_id}.${external_domain_name}"
        ],
        listen_port          => $anthill::nginx::listen_port,

        ssl                  => $anthill::nginx::ssl,
        ssl_port             => $anthill::nginx::ssl_port,
        ssl_cert             => $anthill::nginx::ssl_cert,
        ssl_key              => $anthill::nginx::ssl_key,

        use_default_location => false,
        index_files          => [],
        proxy_http_version => '1.1'
      }

      nginx::resource::location { "${environment}_supervisor/":
        ensure               => present,
        location             => "/",
        server               => "${environment}_supervisor",
        rewrite_rules        => [],
        proxy                => "http://127.0.0.1:${admin_port}",
        proxy_buffering      => 'off',

        ssl => $anthill::nginx::ssl,
        proxy_http_version => '1.1'
      }
    }
    else
    {
      if ($anthill::manage_nginx) {
        nginx::resource::server { "${environment}_supervisor":
          ensure => 'abscent'
        }

        nginx::resource::location { "${environment}_supervisor/":
          ensure => 'abscent'
        }
      }
    }
  }

}